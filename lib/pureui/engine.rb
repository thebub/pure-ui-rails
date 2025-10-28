# frozen_string_literal: true

require "rails/engine"
require "view_component"

module Pureui
  class Engine < ::Rails::Engine
    isolate_namespace Pureui

    # Add app/components to autoload paths
    config.autoload_paths << root.join("app/components")

    # Add vendor/assets to asset paths
    initializer "pureui.assets" do |app|
      app.config.assets.paths << root.join("vendor/assets/javascripts")
      app.config.assets.paths << root.join("vendor/assets/stylesheets")
      app.config.assets.paths << root.join("vendor/assets/images")
    end

    # Precompile Pure UIkit assets
    initializer "pureui.precompile" do |app|
      app.config.assets.precompile += %w[
        pureui/pure-uikit.js
        pureui/themes/light.css
        pureui/themes/dark.css
      ]
    end
  end
end
