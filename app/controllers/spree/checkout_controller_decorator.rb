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

        @order.payments.where(payment_method: @payment_method).each do |payment|
          payment.started_processing!
          # Hacer de cuenta que todos los pagos vienen completos
          payment.complete!
        end
      end
  end
end
