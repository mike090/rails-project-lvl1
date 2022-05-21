# frozen_string_literal: true

module HexletCode
  module HtmlControls
    class << self
      def label(control)
        attrs = control.attributes.dup
        case control
        when Controls::DataControl
          attrs[:for] = control.field_name
          text = control.field_name.to_s.capitalize
        when Controls::TextControl
          text = control.text
        end
        Html.label text, **attrs
      end

      def text_input(control)
        attrs = control.attributes.merge type: :text
        attrs.delete :as
        attrs.merge! name: control.field_name
        text = control.field_value
        Html.text_input text, **attrs
      end

      def textarea(control)
        attrs = { cols: 20, rows: 40 }.merge control.attributes
        attrs.merge! name: control.field_name
        text = control.field_value
        Html.textarea text, **attrs
      end

      def form(form)
        attrs = { method: :post }.merge form.attributes
        attrs[:action] = (attrs.delete :url) || '#'
        form_content = form.controls.map do |control|
          control.field_value = form.model.public_send control.field_name if control.instance_of? Controls::DataControl
          Rendering.render_control control
        end
        Html.form form_content.join, **attrs
      end

      def submit(control)
        caption = case control
                  when Controls::TextControl
                    control.text
                  else
                    control.attributes[:value] || 'Save'
                  end
        tag_attrs = { name: :commit }.merge control.attributes
        Html.submit(caption, **tag_attrs.merge(type: :submit))
      end
    end
  end
end
