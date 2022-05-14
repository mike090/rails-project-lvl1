# frozen_string_literal: true

module HexletCode
  class Form
    extend Forwardable

    def initialize(model, **attrs)
      @model = model
      @data = HexletCode::Controls::FormControl.new(**{ type: :form, data: { attributes: attrs } })
    end

    def to_h
      controls.each do |control|
        if control.is_a?(HexletCode::Controls::DataControl)
          field_name = control.field_name
          @data.model[field_name] = @model.public_send(field_name) unless @data.model.key(field_name)
        end
      end
      @data.to_h
    end

    def_delegators :@data,
                   *(Controls::FormControl.public_instance_methods - public_instance_methods).grep(
                     /#{(Controls::FormControl.data_keys).join '|'}/
                   )

    def respond_to_missing?(*)
      true
    end

    def method_missing(method_name, *args)
      controls << HexletCode::Controls.create_control(method_name, *args)
    end

    alias save to_h
  end
end
