# frozen_string_literal: true

module HexletCode
  module HtmlControls
    class << self
      def label(control)
        attrs = control.attributes.dup
        if control.instance_of? Controls::ModelControl
          attrs[:for] = control.field_name
          text = control.field_name.to_s.capitalize
        end
        Html.label text, **attrs
      end

      def text_input(control)
        attrs = control.attributes.merge type: :text
        attrs.delete :as
        text = ''
        if control.instance_of? Controls::ModelControl
          attrs.merge! name: control.field_name
          text = control.field_value
        end
        Html.text_input text, **attrs
      end

      def textarea(control)
        attrs = { cols: 20, rows: 40 }.merge control.attributes
        if control.instance_of? Controls::ModelControl
          attrs.merge! name: control.field_name
          text = control.field_value
        end
        Html.textarea text, **attrs
      end

      def form(form)
        attrs = { method: :post }.merge form.attributes
        attrs[:action] = (attrs.delete :url) || '#'
        # controls = form.controls.map
        form_content = form.controls.map do |control|
          control.field_value = form.model[control.field_name] if control.instance_of? Controls::ModelControl
          Rendering.render_control control
        end
        Html.form form_content.join, **attrs
      end

      def submit(control)
        tag_attrs = { name: :commit, value: :Save }.merge control.attributes
        Html.submit(**tag_attrs.merge(type: :submit))
      end
    end
  end
end
