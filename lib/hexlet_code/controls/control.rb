# frozen_string_literal: true

module HexletCode
  module Controls
    class Control
      def initialize(name, **attributes)
        raise ArgumentError, 'Unknown control name' unless name

        @name = name
        @attributes = attributes.dup || {}
      end

      attr_reader :attributes

      attr_accessor :name
    end
  end
end