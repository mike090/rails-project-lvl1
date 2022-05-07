# frozen_string_literal: true

module HexletCode
  class InvalidBuilderError < StandardError; end

  module ControlsBuilder
    def self.register_builder(control_name, builder)
      builders[control_name] = builder
    end

    def self.build_control(control_name, **attrs)
      builder = builders[control_name]
      raise ArgumentError, "Unknown contril :#{control_name}" unless builder
      return builder.build(**attrs) if builder.respond_to? :build
      return builder.call(**attrs) if builder.instance_of? Proc

      raise HexletCode::InvalidBuilderError, "Invalid builder for #{control_name}"
    end

    def self.builders
      @builders ||= {}
    end
  end
end
