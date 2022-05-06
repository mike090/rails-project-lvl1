# frozen_string_literal: true

module HexletCode
  class FieldsBuilder
    def initialize(model)
      raise ArgumentError unless model

      @model = model
    end

    def input(attribute_name, **input_attrs)
      field_value = @model.public_send attribute_name
      tag_attrs = input_attrs
      as = tag_attrs.delete :as
      input_tag = if as == :text
                    (
                          textarea attribute_name, field_value, **tag_attrs)
                  else
                    (
                          Tag.build 'input', name: attribute_name, type: 'text', value: field_value.to_s, **tag_attrs)
                  end
      label_tag = label attribute_name, **tag_attrs
      label_tag + input_tag
    end

    def submit(caption = 'Save', **tag_attrs)
      tag_attrs = { name: 'commit', type: 'submit', value: caption }.merge tag_attrs
      Tag.build 'input', **tag_attrs
    end

    def label(attribute_name, **tag_attrs)
      Tag.build('label', for: attribute_name, **tag_attrs) { attribute_name.to_s.capitalize }
    end

    private

    def textarea(attribute_name, value, cols: 20, rows: 40, **tag_attrs)
      Tag.build('textarea', name: attribute_name, cols: cols, rows: rows, **tag_attrs) { value }
    end
  end
end
