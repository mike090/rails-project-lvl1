# frozen_string_literal: true

module HexletCode
  module Controls
    CONTROL_DATA_KEYS = %i[attributes].freeze
    MODEL_DATA_KEYS = (%i[field_name field_value] + CONTROL_DATA_KEYS).freeze
    FORM_DATA_KEYS = (%i[model controls] + CONTROL_DATA_KEYS).freeze

    private_constant :CONTROL_DATA_KEYS, :MODEL_DATA_KEYS, :FORM_DATA_KEYS

    class Control
      extend Forwardable

      def self.data_class
        @data_class ||= Struct.new(*CONTROL_DATA_KEYS, keyword_init: true) do |_struct_class|
          def to_h
            super.tap { |result| result[:attributes] = result[:attributes].dup }
          end

          private :attributes=
        end
      end

      def initialize(**values)
        raise ArgumentError, 'Unknown control type' unless values[:type]

        @type = values[:type]
        data = values[:data] || {}
        data = data.to_a.to_h
        data[:attributes] = data[:attributes].dup || {}
        @data = self.class.data_class.new(**data)
      end

      attr_reader :type

      def data
        { type: @type, data: @data.to_h }
      end

      def_delegators :@data,
                     *(data_class.public_instance_methods - public_instance_methods)
                       .grep(/#{data_class.members.join '|'}/)
    end

    class ModelControl < Control
      def self.data_class
        @data_class ||= Struct.new(*MODEL_DATA_KEYS, keyword_init: true) do |_struct_class|
          def initialize(**values)
            super
            self[:attributes] ||= {}
          end

          private :attributes=
        end
      end

      def_delegators :@data,
                     *(data_class.public_instance_methods - public_instance_methods)
                       .grep(/#{data_class.members.join '|'}/)
    end

    class FormControl < Control
      def self.data_class
        @data_class ||= Struct.new(*FORM_DATA_KEYS, keyword_init: true) do |_struct_class|
          def to_h
            super.tap do |result|
              result[:model] = result[:model].dup
              result[:controls] = result[:controls].map(&:data)
            end
          end

          private :attributes=, :controls=, :model=
        end
      end

      def initialize(**values)
        type = values[:type] || :form
        data = values[:data] || {}
        model = data[:model].dup || {}
        controls = (data[:controls] || []).map { |control_data| Controls.create_control(**control_data) }
        attributes = data[:attributes]
        super(**{ type: type, data: { attributes: attributes, model: model, controls: controls } })
      end

      def_delegators :@data,
                     *(data_class.public_instance_methods - public_instance_methods)
                       .grep(/#{data_class.members.join '|'}/)
    end

    class << self
      def create_control(**control_data)
        control_class = get_control_class control_data[:data].keys
        raise ArgumentError, "Unknown control class for keys: #{control_data[:data].keys}" unless control_class

        control_class.new(**control_data)
      end

      def register_control_class(control_class, *keys)
        control_classes[keys.sort.hash] = control_class
      end

      def get_control_class(keys)
        control_classes[keys.sort.hash]
      end

      def control_classes
        @control_classes ||= {}
      end

      private :get_control_class, :control_classes
    end

    register_control_class Control, *CONTROL_DATA_KEYS
    register_control_class ModelControl, *MODEL_DATA_KEYS
    register_control_class FormControl, *FORM_DATA_KEYS
  end
end
