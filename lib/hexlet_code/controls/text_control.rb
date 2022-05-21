# frozen_string_literal: true

module HexletCode
  module Controls
    class TextControl < Control
      def initialize(name, text, **attributes)
        super(name, **attributes)
        @text = text
      end

      attr_accessor :text
    end
  end
end
