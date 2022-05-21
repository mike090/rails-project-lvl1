# frozen_string_literal: true

module HexletCode
  class Form
    extend Forwardable

    def initialize(model, **attrs)
      @model = model
      @data = HexletCode::Controls::FormControl.new(nil, **attrs)
    end

    def_delegators :@data, 

    def respond_to_missing?(*)
      true
    end

    def method_missing(method_name, *args)
      controls << HexletCode::Controls.create_control(method_name, *args)
    end

    alias save to_h
  end
end
