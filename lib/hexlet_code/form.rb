# frozen_string_literal: true

module HexletCode
  class Form
    def initialize(model, url: '#', **attrs)
      @model = model
      @form_attrs = attrs.merge({ url: url })
      @controls = []
    end

    def structure
      { form: @form_attrs.merge(FORM_CONTROLS_KEY => @controls) }
    end

    def method_missing(method_name, *args)
      check_control_args(*args)
      control_args = args.last.instance_of?(Hash) ? args.last : {}
      if args.first.instance_of? Symbol
        field_name = args.first
        field_value = @model.public_send field_name
        control_args[FIELD_NAME_KEY] = field_name
        control_args[FIELD_VALUE_KEY] = field_value
      end
      add_control method_name, **control_args
    end

    def respond_to_missing?(*)
      true
    end

    private

    def check_control_args(*args)
      return if args.empty?

      pattern = args.map(&:class)
      return if pattern == [Hash]

      if [[Symbol], [Symbol, Hash]].include?(pattern)
        check_field_name args.first
        return
      end
      raise ArgumentError,
            "Invalid control arguments #{args}. Use (_field_name, **args)"
    end

    def check_field_name(field_name)
      return if @model.respond_to? field_name

      raise NoMethodError,
            "Invalid field name '#{field_name}' for model:#{@model.inspect}"
    end

    def add_control(control_type, **attrs)
      @controls << { control_type => attrs }
    end
  end
end
