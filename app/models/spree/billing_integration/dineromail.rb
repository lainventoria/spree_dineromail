# Copiado de Spree::BillingIntegration::Skrill::QuickCheckout
# de spree_gateway
class Spree::BillingIntegration::Dineromail < Spree::BillingIntegration
  preference :merchant, :string
  preference :country_id, :integer
  preference :payment_method_available, :string
  preference :password, :string
  preference :email, :string
  preference :pin, :string

  def provider_class
    ActiveMerchant::Billing::Dineromail
  end

  def redirect_url(order, opts = {})
    opts.merge! self.preferences

    dineromail = self.provider
    dineromail.payment_url(opts)
  end

  def source_required?
    false
  end
end
