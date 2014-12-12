module Spree
  CheckoutController.class_eval do
    after_action :verify_dinero_mail_payment, only: [:update]

    private

      # Usar el IPN para obtener el estado del pago en DineroMail
      def verify_dinero_mail_payment
        # Sólo cuando el checkout está por pagarse
        return unless params[:state] == 'payment'

        @payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

        return unless @payment_method.try(:kind_of?, Spree::BillingIntegration::Dineromail)

        # Para todos los pagos que se hagan con dineromail, verificar
        # con el IPN que se haya completado el proceso con ellos.
        @order.payments.where(payment_method: @payment_method).each do |payment|

          payment.started_processing!

          ipn = DineroMailIpn::Client.new(account: @payment_method.preferences[:merchant],
                                          password: @payment_method.preferences[:password])
          t = ipn.consulta_transacciones([@order.number]).reports.first

          if t.valid? && t.amount == @order.total.to_money.cents
            payment.pend!       if t.transaction_pending?
            payment.complete!   if t.transaction_completed?
            payment.invalidate! if t.transaction_cancelled?
          else
            # El pago no sirve si no se realizó en DineroMail
            payment.invalidate!
          end
        end
      end
  end
end
