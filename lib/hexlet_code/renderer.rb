# frozen_string_literal: true

module HexletCode
  class InvalidBuilderError < StandardError; end

  module Renderer
    class << self
      def register_control(control_name, builder)
        check_builder builder
        builders[control_name] = builder
      end

      def render_control(control_name, **attrs)
        builder = builders[control_name]
        raise ArgumentError, "Unknown contril :#{control_name}" unless builder
        return builder.build(**attrs) if builder.respond_to? :build
        return builder.call(**attrs) if builder.instance_of? Proc

        raise HexletCode::InvalidBuilderError, "Invalid builder for #{control_name}"
      end

      private

      def builders
        @builders ||= {}
      end

      def check_builder(builder)
        return if builder.is_a? Proc
        return if builder.respond_to? :build

        raise ArgumentError, 'Invalid builder. Use instance of Proc or object responsible to :build'
      end
    end
  end
end
