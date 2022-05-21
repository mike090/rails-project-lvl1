# frozen_string_literal: true

require 'test_helper'

class TestControl < Minitest::Test
  def test_empty_control
    target = HexletCode::Controls.create_control :submit
    assert_instance_of HexletCode::Controls::Control, target
    assert { target.name == :submit }
    assert { target.attributes == {} }
  end

  def test_text_control
    control_name = :test_control
    text = 'text'
    attributes = { attr1: :value1 }
    target = HexletCode::Controls.create_control control_name, text, attributes
    assert_instance_of HexletCode::Controls::TextControl, target
    assert { target.name == control_name }
    assert { target.text == text }
    assert { target.attributes == attributes }
  end

  def test_data_control
    field_name = :job
    field_value = :hexlet
    attributes = { attr1: :value1 }
    target = HexletCode::Controls.create_control :input, field_name, attributes
    assert_instance_of HexletCode::Controls::DataControl, target
    target.field_value = field_value
    assert { target.field_name == field_name }
    assert { target.field_value == field_value }
    assert { target.attributes == attributes }
  end
end
