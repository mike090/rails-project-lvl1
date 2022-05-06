# frozen_string_luteral: true

module HexletCode
  module ControlsBuilder
    def self.register_builder(control_name, builder)
      builders[control_name] = builder
    end

    def self.build_control(control_name, **attrs)
      builder = builders[control_name]
      raise ArgumentError, "Unknown contril :#{control_name}" unless builder
      builder.build **attrs
    end

    private

    def self.builders
      @builders ||= {}
    end
  end
end