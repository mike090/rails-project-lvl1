# frozen_string_literal: true

module HexletCode
  module Input
    INPUTS_TYPES = { default: :text_input, text: :textarea }.freeze

    private_constant :INPUTS_TYPES

    Rendering.register_renderer(:input, proc do |control|
      input_type = control.attributes.fetch :as, :default
      begin
        method_name = INPUTS_TYPES.fetch input_type
      rescue KeyError
        raise RenderError, "Invalid input type: #{input_type}"
      end
      [
        HtmlControls.label(control),
        HtmlControls.public_send(method_name, control)
      ].join
    end)
  end
end
