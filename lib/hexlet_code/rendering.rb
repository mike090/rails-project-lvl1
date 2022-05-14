# frozen_string_literal: true

module HexletCode
  class RenderError < StandardError; end

  module Rendering
    class << self
      def register_renderer(control_name, renderer)
        check_renderer renderer
        renderers[control_name] = renderer
      end

      def render_control(control)
        renderer = renderers[control.name]
        raise RenderError, "Unknown contril name: #{control.name}" unless renderer
        return renderer.render(control) if renderer.respond_to? :render
        return renderer.call(control) if renderer.instance_of? Proc
      end

      def registred_renderers
        @renderers.keys
      end

      private

      def renderers
        @renderers ||= {}
      end

      def check_renderer(render)
        return if render.is_a? Proc
        return if render.respond_to? :render

        raise ArgumentError, 'Invalid render. Use instance of Proc or object responsible to :render'
      end
    end
  end
end
