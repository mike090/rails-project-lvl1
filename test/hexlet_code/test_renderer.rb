# frozen_string_literal: true

require 'test_helper'

class TestRenderer < Minitest::Test
  def renderer
    HexletCode::Rendering
  end

  def test_renderer_accepts_proc
    control_name = :test_control
    control_render = 'test_control'
    control_builder = proc { |_control_data| control_render }
    renderer.register_control control_name, control_builder
    target = renderer.render_control(HexletCode::Controls::Control.new(type: control_name))
    assert { target == control_render }
  end

  def test_renderer_accepts_build
    control_name = :test_control
    control_render = 'test_control2'
    control_builder = Object.new
    control_builder.define_singleton_method(:build) { |_control_data| control_render }
    renderer.register_control control_name, control_builder
    target = renderer.render_control(HexletCode::Controls::Control.new(type: control_name))
    assert { target == control_render }
  end

  def test_controls_builder_not_accepts_any
    assert_raises(ArgumentError) { renderer.register_control :test, Object.new }
  end
end
