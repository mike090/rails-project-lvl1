# frozen_string_literal: true

module HexletCode
  module Controls
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

      private :get_control_fabric, :control_fabrics, :register_control_fabric
    end

    register_control(
      Proc.new do |name, *args|
        Controlnew(name, args.first)
      end,
      [], [Hash]
    )
    register_control(
      Proc.new do |name, *args|
        TextControl.new(name, args.first, args[1])
      end,
      [String], [String, Hash]
    )
    register_control(
      Proc.new do |name, *args|
        DataControl.new(name, args.first, args[1])
      end,
      [Symbol], [Symbol, Hash]
    )
  end
end
