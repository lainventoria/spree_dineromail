module Spree
  CheckoutController.class_eval do
    before_filter :verify_dinero_mail_payment, only: [:update]

    private

      # Usar el IPN para obtener el estado del pago en DineroMail
      def verify_dinero_mail_payment
        # Sólo cuando el checkout está por pagarse
        return unless params[:state] == 'payment'

        @payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

        return unless @payment_method.try(:kind_of?, Spree::BillingIntegration::Dineromail)

        # FIXME en este punto siempre está vacío.  El pago se autocrea
        # con estado "checkout" más tarde y queda duplicado.
        if @order.payments.empty?
          payment = @order.payments.create({amount: @order.total,
                      payment_method: @payment_method})
          payment.started_processing!

          # Chequear contra dineromail el estado del pago
# FIXME habilitar cuando tengamos una cuenta para probar
#         ipn = DineroMailIpn.new(account: @payment_method.preferences[:merchant],
#                 password: @payment_method.preferences[:password])
#         t = ipn.consulta_transacciones([@order.number]).reports.first
#         if t.valid? && t.amount == @order.total.to_money.cents
            payment.pend! # if t.transaction_pending?
#         else
#           TODO cancelar la orden si el checkout de dineromail se hizo
#           incorrectamente
#         end
        end
      end
  end
end
