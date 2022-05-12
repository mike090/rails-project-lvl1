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
      control_attrs = args.last.instance_of?(Hash) ? args.last : {}
      case args.first
      when Symbol
        add_data_control method_name, args.first, **control_attrs
      when String
        add_text_control method_name, args.first, **control_attrs
      else
        add_control method_name, **control_attrs
      end
    end

    private

    def check_control_args(args)
      return if args.empty?

      params_map = args.map(&:class)
      unless [[String], [Symbol], [Hash], [String, Hash], [Symbol, Hash]].include? params_map
        raise ArgumentError,
              "Invalid control arguments #{args}. Use (_field_name|_text, **args)"
      end

      check_field_name args.first if params_map.first == Symbol
    end

    def check_field_name(field_name)
      return if @model.respond_to? field_name

      raise NoMethodError,
            "Invalid field name '#{field_name}' for model:#{@model.inspect}"
    end

    def add_control(control_type, **attrs)
      control = HexletCode::Controls::Control.new(**{ type: control_type, data: { attributes: attrs } })
      @data.controls << control
    end

    def add_text_control(control_type, text, **attrs)
      control = HexletCode::Controls::TextControl.new(**{ type: control_type,
                                                          data: { text: text, attributes: attrs } })
      @data.controls << control
    end

    def add_data_control(control_type, field_name, **attrs)
      @data.model[field_name] = @model.public_send field_name unless @data.model.key? field_name
      control = HexletCode::Controls::DataControl.new(**{ type: control_type,
                                                          data: { field_name: field_name, attributes: attrs } })
      @data.controls << control
    end
  end
end
