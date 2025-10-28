# frozen_string_literal: true

module Pureui
  class FormBuilder < ActionView::Helpers::FormBuilder
    # Text input field
    def input(method, options = {})
      render_input_component(method, Pureui::Form::InputComponent, options)
    end

    # Textarea field
    def textarea(method, options = {})
      render_input_component(method, Pureui::Form::TextareaComponent, options)
    end

    # Select dropdown
    def select(method, choices = nil, select_options = {}, component_options = {})
      selected_value = object_value(method)

      render_component(
        Pureui::Form::SelectComponent,
        method,
        component_options.merge(
          choices: choices,
          selected: selected_value,
          name: field_name(method),
          id: field_id(method)
        )
      )
    end

    # Checkbox field
    def checkbox(method, options = {}, checked_value = "1", unchecked_value = "0")
      value = object_value(method)
      checked = value == checked_value || (checked_value == "1" && value == true)

      render_component(
        Pureui::Form::CheckboxComponent,
        method,
        options.merge(
          checked: checked,
          value: checked_value,
          name: field_name(method),
          id: field_id(method)
        )
      )
    end

    # Radio button
    def radio(method, tag_value, options = {})
      value = object_value(method)
      checked = value.to_s == tag_value.to_s

      render_component(
        Pureui::Form::RadioComponent,
        method,
        options.merge(
          checked: checked,
          value: tag_value,
          name: field_name(method),
          id: "#{field_id(method)}_#{tag_value.to_s.parameterize}"
        )
      )
    end

    # Switch toggle
    def switch(method, options = {})
      value = object_value(method)
      checked = value == true || value == "1"

      render_component(
        Pureui::Form::SwitchComponent,
        method,
        options.merge(
          checked: checked,
          name: field_name(method),
          id: field_id(method)
        )
      )
    end

    # Color picker
    def color_picker(method, options = {})
      render_input_component(method, Pureui::Form::ColorPickerComponent, options)
    end

    # Range slider
    def range(method, options = {})
      render_input_component(method, Pureui::Form::RangeComponent, options)
    end

    # Submit button
    def submit(value = nil, options = {})
      value ||= submit_default_value
      options[:variant] ||= "primary"
      options[:type] = "submit"

      @template.render(Pureui::ButtonComponent.new(**options)) do
        value
      end
    end

    private

    def render_input_component(method, component_class, options = {})
      render_component(
        component_class,
        method,
        options.merge(
          value: object_value(method),
          name: field_name(method),
          id: field_id(method)
        )
      )
    end

    def render_component(component_class, method, options = {})
      # Extract label and help text
      label_text = options.delete(:label)
      help_text = options.delete(:help_text)
      wrapper_class = options.delete(:wrapper_class)

      # Check for errors
      errors = object_errors(method)
      has_errors = errors.any?

      # Add error state to component
      if has_errors
        options[:invalid] = true
        options[:class] = [options[:class], "is-invalid"].compact.join(" ")
      end

      @template.content_tag(:div, class: ["form-group", wrapper_class].compact.join(" ")) do
        html = "".html_safe

        # Add label if provided
        if label_text
          html += @template.content_tag(:label, label_text, for: options[:id], class: "form-label")
        end

        # Render the component
        html += @template.render(component_class.new(**options))

        # Add help text if provided
        if help_text && !has_errors
          html += @template.content_tag(:small, help_text, class: "form-text text-muted")
        end

        # Add error messages
        if has_errors
          html += @template.render(Pureui::Form::ErrorComponent.new(errors: errors))
        end

        html
      end
    end

    def object_value(method)
      @object.public_send(method) if @object.respond_to?(method)
    end

    def object_errors(method)
      return [] unless @object.respond_to?(:errors)
      @object.errors[method]
    end

    def field_name(method)
      "#{@object_name}[#{method}]"
    end

    def field_id(method)
      "#{@object_name}_#{method}"
    end

    def submit_default_value
      object = convert_to_model(@object)
      key = object ? (object.persisted? ? :update : :create) : :submit
      model = if object.class.respond_to?(:model_name)
                object.class.model_name.human
              else
                @object_name.to_s.humanize
              end
      I18n.t("helpers.submit.#{key}", model: model, default: "#{key.to_s.humanize} #{model}")
    end
  end
end
