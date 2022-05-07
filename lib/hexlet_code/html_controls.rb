# frozen_string_literal: true

module HexletCode
  module HtmlControls
    def label(**attrs)
      label_attrs = attrs
      label_field = label_attrs.delete FIELD_NAME_KEY
      label_text = label_attrs.delete FIELD_VALUE_KEY
      label_attrs[:for] = label_field if label_field
      Tag.build('label', **label_attrs) { label_text }
    end

    def text_input(**attrs)
      tag_attrs = attrs.merge type: :text
      field_name = tag_attrs.delete FIELD_NAME_KEY
      field_value = tag_attrs.delete FIELD_VALUE_KEY
      tag_attrs.merge! name: field_name if field_name
      tag_attrs.merge! value: field_value if field_value
      Tag.build 'input', **tag_attrs
    end

    # def checkbox(**attrs)
    #   checkbox_checked = block_given? ? yield : checked
    #   input_attrs = attrs.merge({ type: :checkbox, value: value })
    #   input_attrs = input_attrs.merge({ checked: nil })  if checked
    #   Tag.build :input, input_attrs
    # end

    def form(**attrs)
      tag_attrs = attrs
      tag_attrs[:action] = tag_attrs.delete :url
      controls = (tag_attrs.delete FORM_CONTROLS_KEY) || []
      form_content = controls.map do |control_data|
        control_name = control.keys.first
        control_attrs = control_data[control_name]
        ControlsBuilder.build_control control_name, control_attrs
      end.join
      Tag.build('form', **tag_attrs) { form_content }
    end

    def textarea(**attrs)
      tag_attrs = { cols: 20, rows: 40 }.merge attrs
      field_name = tag_attrs.delete FIELD_NAME_KEY
      field_value = tag_attrs.delete FIELD_VALUE_KEY
      tag_attrs.merge! name: field_name if field_name
      Tag.build('textarea', **tag_attrs) { field_value }
    end

    def submit(**attrs)
      tag_attrs = { name: :commit, value: :Save }.merge attrs
      tag_attrs.merge! type: :submit
      Tag.build 'input', **tag_attrs
    end

    private

    def register_controls
      # CONTROLS.each do |control, method|
      #   builder = Class.new
      #   builder.define_singelton_method :build { |attrs|
      #     self.public_send method, **attrs
      #   }

      # end
    end
  end
end
