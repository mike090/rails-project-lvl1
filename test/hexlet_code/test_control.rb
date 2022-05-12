# frozen_string_literal: true

require 'test_helper'

class TestControl < Minitest::Test
  def test_control
    control = HexletCode::Controls::DataControl.new(type: :test_control)
    control.field_name = :job
    control.attributes[:as] = :text
    target = HexletCode::Controls::DataControl.new(**control.data)
    assert { target.type == :test_control }
    assert { target.field_name == :job }
    assert { target.attributes == { as: :text } }
  end

  def test_control_def_values
    control = HexletCode::Controls::Control.new type: :label
    assert { control.data == { type: :label, data: { attributes: {} } } }
  end
end
