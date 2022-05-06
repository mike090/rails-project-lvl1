# frozen_string_literal: true

module HexletCode
  class Form
    def initialize(model, url: '#', **attrs)
      @model = model
      @form_attrs = attrs.merge({ url: url })
      @controls = []
    end

    def structure
      @form_attrs.merge controls: @controls
    end

    def input(field_name, **attrs)
      field_value = @model.public_send field_name
      input_attrs = attrs.merge field_name: field_name, field_value: field_value
      add_control :input, **input_attrs 
    end

    def submit(**attrs)
      add_control :submit, **attrs
    end

    private

    def add_control(control_type, **attrs)
      @controls << { form_control: control_type, **attrs}
    end
  end
end