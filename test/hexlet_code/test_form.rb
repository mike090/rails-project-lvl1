# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def model
    @model ||= User.new name: 'Rob'
  end

  def test_empty_form_data
    form = HexletCode::Form.new model
    assert { form.data == { type: :form, data: { model: {}, controls: [], attributes: {} } } }
  end

  def test_form
    form_attrs = { form_attr1: :value1, form_attr2: :value2 }
    control_attrs = { control_attr1: :value1, control_attr2: :value2 }
    form = HexletCode::Form.new model, **form_attrs
    form.test_control1 :name, **control_attrs
    form.test_control2
    form.test_control3 'text'

    assert_instance_of HexletCode::Controls::DataControl, form.controls.first
    assert_instance_of HexletCode::Controls::Control, form.controls[1]
    assert_instance_of HexletCode::Controls::TextControl, form.controls.last
  end
end
