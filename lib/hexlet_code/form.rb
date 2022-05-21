# frozen_string_literal: true

module HexletCode
  class Form < Controls::FormControl
    def respond_to_missing?(method_name, _include_all)
      method_name = method_name.to_sym if method_name.is_a? String
      Rendering.registred_renderers.include? method_name
    end

    def method_missing(method_name, *args)
      raise ArgumentError, "Unknown control #{method_name}" unless Rendering.registred_renderers.include? method_name

      controls << HexletCode::Controls.create_control(method_name, *args)
    end
  end
end
