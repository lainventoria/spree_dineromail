module ActiveMerchant
  module Billing
    class Dineromail < Gateway
      def service_url
        'https://checkout.dineromail.com/CheckOut'
      end

      def payment_url(opts)
        post = PostData.new
        post.merge! opts

        "#{service_url}?#{post.to_s}"
      end
    end
  end
end
