# frozen_string_literal: true

module HexletCode
  class RenderError < StandardError; end

  module Rendering
    class << self
      def register_control(control_name, builder)
        check_builder builder
        builders[control_name] = builder
      end

      def render_control(control)
        builder = builders[control.type]
        raise RenderError, "Unknown contril type: #{control.type}" unless builder
        return builder.build(control) if builder.respond_to? :build
        return builder.call(control) if builder.instance_of? Proc
      end

      def registred_controls
        @builders.keys
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
