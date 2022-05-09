# frozen_string_literal: true

require 'test_helper'

class TestControlsBuilder < Minitest::Test
  def renderer
    HexletCode::Renderer
  end

  def test_controls_builder_accepts_proc
    control_name = :test_control
    control_render = 'test_control'
    control_builder = proc { control_render }
    renderer.register_control control_name, control_builder
    target = renderer.render_control control_name
    assert { target == control_render }
  end

  def test_controls_builder_accepts_build
    control_name = :test_control
    control_render = 'test_control'
    control_builder = Object.new
    control_builder.define_singleton_method(:build) { control_render }
    renderer.register_control control_name, control_builder
    target = renderer.render_control control_name
    assert { target == control_render }
  end

  def test_controls_builder_not_accepts_any
    assert_raises(ArgumentError) { renderer.register_control :test, Object.new }
  end
end
