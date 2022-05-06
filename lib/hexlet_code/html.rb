# frozen_string_literal: true

module HexletCode
  module Html
    def self.label(caption, **attrs)
      label_text = block_given? ? yield : caption
      Tag.build(:label, **attrs) { label_text }
    end

    def self.text_input(value, **attrs)
      input_attrs = attrs.merge { type: :text, value: value }
      Tag.build :input, **input_attrs
    end

    def self.checkbox(checked, value, **attrs)
      checkbox_checked = block_given? yield : checked
      input_attrs = attrs.merge { type: :checkbox, value: value }
      input_attrs = input_attrs.merge { checked: nil } if checked
      Tag.build :input, 
    end

    def self.date_input
      
    end

    def self.email_input
      
    end

    def self.password_input
      
    end
  end
end