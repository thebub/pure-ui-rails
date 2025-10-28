# frozen_string_literal: true

module Pureui
  class BaseComponent < ViewComponent::Base
    attr_reader :tag_name, :attributes, :parts

    def initialize(tag_name:, parts: {}, **attributes)
      @tag_name = tag_name
      @parts = parts
      @attributes = attributes
      @component_class = self.class.name.demodulize.underscore.dasherize
      super()
    end

    def call
      tag.public_send(tag_name, content, **processed_attributes)
    end

    private

    def processed_attributes
      attrs = attributes.dup

      # Add the pureui-vc- prefixed class
      base_class = "pureui-vc-#{@component_class}"
      attrs[:class] = combine_classes(base_class, attrs[:class])

      # Add part attribute if parts are defined
      if parts.any?
        attrs[:part] = parts.keys.join(" ")
      end

      # Convert boolean attributes
      attrs.transform_values! do |value|
        case value
        when true
          true
        when false, nil
          nil
        else
          value
        end
      end

      attrs.compact
    end

    def combine_classes(*classes)
      classes.flatten.compact.map do |klass|
        klass.is_a?(Array) ? klass.join(" ") : klass
      end.join(" ").strip
    end

    def part_styles
      return "" if parts.empty?

      parts.map do |part_name, styles|
        selector = ".pureui-vc-#{@component_class}::part(#{part_name})"
        "#{selector} { #{styles} }"
      end.join("\n")
    end
  end
end
