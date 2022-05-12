# frozen_string_literal: true

module HexletCode
  class Form
    extend Forwardable

    def_delegators :@data,
                   *(Controls::FormControl.public_instance_methods - public_instance_methods).grep(
                     /#{(Controls::FormControl.data_class.members << :data).join '|'}/
                   )

    def initialize(model, **attrs)
      @model = model
      @data = HexletCode::Controls::FormControl.new(**{ type: :form, data: { attributes: attrs } })
      # @data = ControlData.new model: {}, controls: [], attributes: attrs
    end

    def respond_to_missing?(*)
      true
    end

    def method_missing(method_name, *args)
      check_control_args(args)
      field_name = args.first if args.first.instance_of? Symbol
      control_attrs = args.last if args.last.instance_of? Hash
      control_attrs ||= {}
      add_control method_name, field_name, **control_attrs
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

    def add_control(control_type, field_name, **attrs)
      if field_name
        @data.model[field_name] = @model.public_send field_name unless @data.model.key? field_name
        control = HexletCode::Controls::ModelControl.new(**{ type: control_type,
                                                             data: { field_name: field_name, attributes: attrs } })
      else
        control = HexletCode::Controls::Control.new(**{ type: control_type, data: { attributes: attrs } })
      end
      @data.controls << control
    end
  end
end
