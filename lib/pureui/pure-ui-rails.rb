# frozen_string_literal: true

require_relative "pureui/version"
require_relative "pureui/engine"
require_relative "pureui/configuration"
require_relative "pureui/form_builder"

module Pureui
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
