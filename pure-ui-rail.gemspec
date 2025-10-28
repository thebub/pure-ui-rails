# frozen_string_literal: true

require_relative "lib/pureui/view_components/version"

Gem::Specification.new do |spec|
  spec.name = "pure-ui-rails"
  spec.version = Pureui::VERSION
  spec.authors = ["Daniel Bub"]
  spec.email = ["thebub@users.noreply.github.com"]

  spec.summary = "A pure-ui wrapper for rails applications using view-components"
  spec.description = "A Ruby gem that provides ViewComponent wrappers for Pure UI, making it easy to use Pure UI components in Rails applications"
  spec.homepage = "https://github.com/thebub/pure-ui-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,lib,vendor,config}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "railties", ">= 7.0"
  spec.add_dependency "view_component", "~> 3.0"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 6.0"
  spec.add_development_dependency "capybara", "~> 3.0"
  spec.add_development_dependency "selenium-webdriver", "~> 4.0"
  spec.add_development_dependency "simplecov", "~> 0.22"
  spec.add_development_dependency "factory_bot_rails", "~> 6.0"
end
