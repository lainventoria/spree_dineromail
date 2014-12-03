module SpreeDineromail
  class Engine < Rails::Engine
    require 'spree/core'
    engine_name 'spree_dineromail'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.dineromail.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::Gateway::Dineromail
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end

