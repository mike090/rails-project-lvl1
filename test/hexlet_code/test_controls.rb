# frozen_string_literal: true

require 'test_helper'

class TestControl < Minitest::Test
  def test_empty_control
    control = HexletCode::Controls.create_control :submit
    target = HexletCode::Controls.load_control(**control.to_h)
    assert_instance_of HexletCode::Controls::Control, target
    assert { target.name == control.name }
    assert { target.attributes == control.attributes }
  end

  def test_text_control
    control_name = :test_control
    text = 'text'
    attributes = { attr1: :value1 }
    control = HexletCode::Controls.create_control control_name, text, attributes
    target = HexletCode::Controls.load_control(**control.to_h)
    assert { target.name == control_name }
    assert { target.text == text }
    assert { target.attributes == attributes }
  end

  def test_data_control
    field_name = :job
    field_value = :hexlet
    attributes = { attr1: :value1 }
    control = HexletCode::Controls.create_control :input, field_name, attributes
    control.field_value = field_value
    target = HexletCode::Controls.load_control(**control.to_h)
    assert { target.field_name == field_name }
    assert { target.field_value == field_value }
    assert { target.attributes == attributes }
  end

  def test_form_control_test
    model = { name: 'Rob' }
    form = HexletCode::Controls::FormControl.new(data: { model: model })
    form.controls << HexletCode::Controls.create_control(:input, :name)
    form.controls << HexletCode::Controls.create_control(:submit, 'Save')
    target = HexletCode::Controls.load_control(**form.to_h)
    assert { target.model == model }
    assert { target.controls.count == 2 }
  end
end
