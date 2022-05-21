# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def model
    @model ||= User.new name: 'Rob'
  end

  def test_empty_form_data
    form = HexletCode::Form.new model
    assert do
      form.to_h == { type: HexletCode::Controls::FormControl.hash, name: :form,
                     data: { model: {}, controls: [], attributes: {} } }
    end
  end

  def test_form_create
    form = HexletCode::Form.new model, **{ form_attr1: :value1 }
    form.test_control1 :name
    form.test_control2
    form.test_control3 'text'

    assert form.controls.count == 3
  end

  def test_form_raises
    form = HexletCode::Form.new model, **{ form_attr1: :value1 }
    form.input :age
    assert_raises(NoMethodError) { form.to_h }
  end
end
