# frozen_string_literal: true

module HexletCode
  class FieldsBuilder
    def initialize(model)
      raise ArgumentError unless model

      @model = model
    end

    def input(attribute_name, **tag_attrs)
      field_value = @model.public_send attribute_name
      as = tag_attrs.delete :as
      return textarea attribute_name, field_value, **tag_attrs if as == :text

      Tag.build 'input', name: attribute_name, type: 'text', value: field_value
    end

    def submit; end

    private

    def textarea(attribute_name, value, cols: 20, rows: 40, **tag_attrs)
      Tag.build('textarea', name: attribute_name, cols: cols, rows: rows, **tag_attrs) { value }
    end
  end
end
