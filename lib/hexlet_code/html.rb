# frozen_string_literal: true

module HexletCode
  module Html
    class << self
      def label(text, **attrs)
        Tag.build('label', **attrs) { text }
      end

      def text_input(text, **attrs)
        Tag.build 'input', **attrs.merge(value: text)
      end

      def form(content, **attrs)
        Tag.build('form', **attrs) { content }
      end

      def textarea(text, **attrs)
        Tag.build('textarea', **attrs) { text }
      end

      def submit(caption, **attrs)
        Tag.build 'input', **attrs.merge(value: caption)
      end

      def div(**attrs, &block)
        Tag.build 'div', **attrs, &block
      end

      def h4(text, **attrs)
        Tag.build('h4', **attrs) { text }
      end

      def hr(**attrs)
        Tag.build 'hr', **attrs
      end
    end
  end
end
