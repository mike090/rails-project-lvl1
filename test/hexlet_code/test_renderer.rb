# frozen_string_literal: true

require 'test_helper'

class TestRenderer < Minitest::Test
  def rendering
    HexletCode::Rendering
  end

  def test_rendering_accepts_proc
    control_name = :test_control
    control_render = 'test_control'
    renderer = proc { |_control_data| control_render }
    rendering.register_renderer control_name, renderer
    control = HexletCode::Controls.create_control control_name
    target = rendering.render_control control
    assert { target == control_render }
  end

  def test_rendering_accepts_objects
    control_name = :test_control
    control_render = 'test_control2'
    renderer = Object.new
    renderer.define_singleton_method(:render) { |_control_data| control_render }
    rendering.register_renderer control_name, renderer
    target = rendering.render_control(HexletCode::Controls.create_control(control_name))
    assert { target == control_render }
  end

  def test_controls_rendering_not_accepts_any
    assert_raises(ArgumentError) { rendering.register_renderer :test, Object.new }
  end
end
