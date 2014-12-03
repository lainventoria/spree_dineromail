# -*- encoding: utf-8 -*-
# stub: spree_dineromail 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "spree_dineromail"
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nicolas Justiniano", "Nicolás Reynolds"]
  s.date = "2014-12-03"
  s.email = "spree_dineromail@lainventoria.com.ar"
  s.files = ["LICENSE",
      "README.md",
      "app/models",
      "app/models/spree",
      "app/models/spree/gateway",
      "app/models/spree/gateway/dineromail.rb",
      "app/views",
      "app/views/spree",
      "app/views/spree/checkout",
      "app/views/spree/checkout/payment",
      "app/views/spree/checkout/payment/_dineromail.html.erb",
      "app/views/spree/orders",
      "app/views/spree/orders/show.html.erb",
      "app/views/spree/shared",
      "app/views/spree/shared/_dineromail_form.html.erb",
      "lib/spree_dineromail.rb",
      "lib/spree_dineromail/engine.rb",
      "lib/tasks",
      "lib/tasks/install.rake",
      "lib/tasks/spree_dineromail.rake"]
  s.homepage = "http://github.com/lainventoria/spree_dineromail"
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0")
  s.requirements = ["none"]
  s.rubygems_version = "2.2.2"
  s.summary = "Spree offsite gateway for Dineromail"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spree_core>, ["~> 2.3.0"])
    else
      s.add_dependency(%q<spree_core>, ["~> 2.3.0"])
    end
  else
    s.add_dependency(%q<spree_core>, ["~> 2.3.0"])
  end
end
