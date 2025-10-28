# frozen_string_literal: true

module Pureui
  module Form
    class BaseInputComponent < Pureui::BaseComponent
      attr_reader :value, :name, :invalid

      def initialize(tag_name:, parts: {}, value: nil, name: nil, invalid: false, **attributes)
        @value = value
        @name = name
        @invalid = invalid

        # Add form-specific attributes
        attributes[:name] = name if name
        attributes[:value] = value if value && !attributes.key?(:value)

        super(tag_name: tag_name, parts: parts, **attributes)
      end

      private

      def processed_attributes
        attrs = super

        # Add invalid state if there are errors
        if @invalid
          attrs[:"help-text"] = nil # Will be set by error component
        end

        attrs
      end
    end
  end
end
