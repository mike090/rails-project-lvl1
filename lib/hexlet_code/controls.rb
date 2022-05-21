# frozen_string_literal: true

module HexletCode
  module Controls
    autoload :Control, 'hexlet_code/controls/control.rb'
    autoload :DataControl, 'hexlet_code/controls/data_control.rb'
    autoload :TextControl, 'hexlet_code/controls/text_control.rb'
    autoload :FormControl, 'hexlet_code/controls/form_control.rb'

    class << self
      def create_control(name, *args)
        params_map = args.map(&:class)
        control_fabric = get_control_fabric params_map
        raise ArgumentError, "Unknown control type with params map: #{params_map}" unless control_fabric

        control_fabric.call name, *args
      end

      def register_control(fabric, *params_maps)
        params_maps.each do |params_map|
          control_fabrics[params_map.hash] = fabric
        end
      end

      def get_control_fabric(params_map)
        control_fabrics[params_map.hash]
      end

      def control_fabrics
        @control_fabrics ||= {}
      end

      private :get_control_fabric, :control_fabrics
    end

    register_control(
      proc do |name, *args|
        Control.new name, **(args.first || {})
      end,
      [], [Hash]
    )
    register_control(
      proc do |name, *args|
        TextControl.new name, args.first, **(args[1] || {})
      end,
      [String], [String, Hash]
    )
    register_control(
      proc do |name, *args|
        DataControl.new name, args.first, **(args[1] || {})
      end,
      [Symbol], [Symbol, Hash]
    )
  end
end
