# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def model
    @model ||= User.new name: 'Rob'
  end

  def test_empty_form_data
    form = HexletCode::Form.new model
    assert form.respond_to?(:submit)
    assert form.respond_to?(:input)
  end

  def test_form_create_controls
    form = HexletCode::Form.new model, **{ form_attr1: :value1 }
    form.label 'text'
    form.text_input :name
    form.submit
    assert form.controls.count == 3
  end

  def test_form_raises
    form = HexletCode::Form.new model, **{ form_attr1: :value1 }
    assert_raises(ArgumentError) { form.unregistred_control }
  end
end
