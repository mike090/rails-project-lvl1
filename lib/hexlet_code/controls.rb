# frozen_string_literal: true

module HexletCode
  module Controls
    class << self
      def load_control(**control_data)
        data_keys = (control_data[:data] || {}).keys
        control_loader = get_control_loader data_keys
        raise ArgumentError, "Unknown control loader for keys: #{data_keys}" unless control_loader

        control_loader.call(**control_data)
      end

      def create_control(name, *args)
        params_map = args.map(&:class)
        control_fabric = get_control_fabric params_map
        raise ArgumentError, "Unknown control type with params map: #{params_map}" unless control_fabric

        control_fabric.call name, *args
      end

      def register_control_loader(control_loader, *keys)
        control_loaders[keys.sort.hash] = control_loader
      end

      def register_control_fabric(fabric, *params_maps)
        params_maps.each do |params_map|
          if control_fabrics[params_map.hash]
            raise ArgumentError,
                  "Control fabric for params map #{params_map} already registred"
          end

          control_fabrics[params_map.hash] = fabric
        end
      end

      def get_control_loader(keys)
        control_loaders[keys.sort.hash]
      end

      def get_control_fabric(params_map)
        control_fabrics[params_map.hash]
      end

      def control_loaders
        @control_loaders ||= {}
      end

      def control_fabrics
        @control_fabrics ||= {}
      end

      private :get_control_loader, :get_control_fabric, :control_loaders, :control_fabrics
    end

    class Control
      def self.params_maps
        [[], [Hash]]
      end

      def self.data_keys
        [:attributes]
      end

      def self.create_control(name, *args)
        new(**{ name: name, data: { attributes: (args.first || {}) } })
      end

      attr_reader :attributes

      attr_accessor :name

      def initialize(**values)
        raise ArgumentError, 'Unknown control name' unless values[:name]

        self.name = values[:name]
        @attributes = (values[:data] || {})[:attributes].dup || {}
        # @data = self.class.data_class.new(**values[:data])
      end

      def to_h
        { name: name, data: { attributes: @attributes.dup } }
      end
    end

    class TextControl < Control
      def self.params_maps
        [[String], [String, Hash]]
      end

      def self.create_control(name, *args)
        new(**{ name: name, data: { text: args.first, attributes: (args[1] || {}) } })
      end

      def self.data_keys
        superclass.data_keys << :text
      end

      attr_accessor :text

      def initialize(**values)
        super
        @text = (values[:data] || {})[:text]
      end

      def to_h
        super.tap { |result| result[:data].merge! text: @text }
      end
    end

    class DataControl < Control
      def self.params_maps
        [[Symbol], [Symbol, Hash]]
      end

      def self.create_control(name, *args)
        new(**{ name: name, data: { field_name: args.first, attributes: (args[1] || {}) } })
      end

      def self.data_keys
        superclass.data_keys.concat %i[field_name field_value]
      end

      attr_accessor :field_name, :field_value

      def initialize(**values)
        super
        @field_name = (values[:data] || {})[:field_name]
        @field_value = (values[:data] || {})[:field_value]
      end

      def to_h
        super.tap { |result| result[:data].merge! field_name: @field_name, field_value: @field_value }
      end
    end

    class FormControl < Control
      def self.data_keys
        superclass.data_keys.concat %i[model controls]
      end

      attr_reader :model, :controls

      def initialize(**values)
        values[:name] ||= :form
        super
        @model = (values[:data] || {})[:model].dup || {}
        @controls = ((values[:data] || {})[:controls] || []).map do |control_data|
          Controls.load_control(**control_data)
        end
      end

      def to_h
        super.tap do |result|
          result[:data][:model] = @model.dup
          result[:data][:controls] = @controls.map(&:to_h)
        end
      end
    end

    register_control_fabric (Control.method :create_control).to_proc, *Control.params_maps
    register_control_fabric (TextControl.method :create_control).to_proc, *TextControl.params_maps
    register_control_fabric (DataControl.method :create_control).to_proc, *DataControl.params_maps

    register_control_loader (Control.method :new).to_proc, *Control.data_keys
    register_control_loader (DataControl.method :new).to_proc, *DataControl.data_keys
    register_control_loader (FormControl.method :new).to_proc, *FormControl.data_keys
    register_control_loader (TextControl.method :new).to_proc, *TextControl.data_keys
  end
end
