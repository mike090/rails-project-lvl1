# frozen_string_literal: true

module HexletCode
  module Controls
    class DataControl < Control
      def initialize(name, field_name, **attributes)
        super(name, **attributes)
        @field_name = field_name
      end

      attr_accessor :field_name, :field_value
    end
  end
end
