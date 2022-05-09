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
      check_control_args(args)
      field_name = args.first if args.first.instance_of? Symbol
      control_attrs = args.last if args.last.instance_of? Hash
      control_attrs ||= {}
      add_control method_name, field_name, control_attrs
    end

    def respond_to_missing?(*)
      true
    end

    private

    def check_control_args(args)
      return if args.empty?

      params_map = args.map(&:class)
      unless [[Symbol], [Hash], [Symbol, Hash]].include? params_map
        raise ArgumentError,
              "Invalid control arguments #{args}. Use (_field_name, **args)"
      end

      check_field_name args.first if params_map.first == Symbol
    end

    def check_field_name(field_name)
      return if @model.respond_to? field_name

      raise NoMethodError,
            "Invalid field name '#{field_name}' for model:#{@model.inspect}"
    end

    def add_control(control_type, field_name, attrs)
      control = { HexletCode::CONTROL_TYPE_KEY => control_type, HexletCode::CONTROL_ATTRS_KEY => attrs }
      if field_name
        field_value = @model.public_send field_name
        control.merge! FIELD_NAME_KEY => field_name, FIELD_VALUE_KEY => field_value
      end
      @controls << control
    end
  end
end
