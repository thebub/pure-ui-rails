# frozen_string_literal: true

module Pureui
  class Configuration
    attr_accessor :default_theme, :auto_import_styles

    def initialize
      @default_theme = :light
      @auto_import_styles = true
    end
  end
end
