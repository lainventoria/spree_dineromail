module Spree
  CheckoutController.class_eval do
    before_filter :get_dinero_mail_status, only: [:update]

    private

      # Usar el IPN para obtener el estado del pago en DineroMail
      def get_dinero_mail_status
        return unless params[:state] == 'payment'

        @payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

        return unless @payment_method.try(:kind_of?, Spree::BillingIntegration::Dineromail)

        ipn = DineroMailIpn.new(account: @payment_method.preferences[:merchant],
          password: @payment_method.preferences[:password])

        t = ipn.consulta_transacciones([@order.number]).reports.first

        if t.valid? && t.amount == @order.total.to_money.cents
          if t.transaction_completed?
            state = 'complete'
          elsif t.transaction_pending?
            state = 'confirm'
          elsif t.transaction_cancelled?
            state = 'canceled'
          end

          @order.update_attributes({state: state})
        end
      end
  end
end
