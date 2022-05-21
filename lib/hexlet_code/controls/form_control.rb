# frozen_string_literal: true

module HexletCode
  module Controls
    class FormControl < Control
      def initialize(model, **attributes)
        super(:form, **attributes)
        @model = model
        @controls = []
      end

      attr_reader :model, :controls
    end
  end
end
