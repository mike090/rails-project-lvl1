# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def model
    @model ||= User.new name: 'Rob'
  end

  def test_empty_form
    form = HexletCode::Form.new model
    form_data = form.structure[:form]
    assert { form_data == { url: '#', HexletCode::FORM_CONTROLS_KEY => [] } }
  end

  def test_form_keep_control
    form = HexletCode::Form.new model
    form.test_control
    form.test_control attr1: :value1, attr2: :value2
    form_data = form.structure[:form]
    assert form_data[HexletCode::FORM_CONTROLS_KEY].count == 2
    assert form_data[HexletCode::FORM_CONTROLS_KEY].include?({ test_control: {} }),
           "#{form_data} :controls should include '{test_control: {}}'"
    assert form_data[HexletCode::FORM_CONTROLS_KEY].include?({ test_control: { attr1: :value1, attr2: :value2 } }),
           "#{form_data} :controls should include '{test_control: {attr1: :value1, attr2: :value2}}'"
  end

  def test_form_keep_attrs
    form = HexletCode::Form.new model, method: :put
    form.test_control
    form_data = form.structure[:form]
    assert { form_data[:url] == '#' }
    assert { form_data[:method] == :put }
  end

  def test_form_keep_model_data
    form = HexletCode::Form.new model
    field_name = :name
    field_value = @model.name
    form.test_control field_name, attr1: :value1
    form_data = form.structure[:form]
    test_control_data = form_data[HexletCode::FORM_CONTROLS_KEY].first[:test_control]
    assert test_control_data[HexletCode::FIELD_NAME_KEY] = field_name
    assert test_control_data[HexletCode::FIELD_VALUE_KEY] = field_value
    assert test_control_data[:attr1] = :value1
  end

  def test_rises_for_invalid_field_name
    form = HexletCode::Form.new model
    field_name = :age
    assert_raises(NoMethodError, "Form should raise exception if model model has'nt field") do
      form.test_control field_name
    end
  end

  def test_rises_for_invalid_arguments_type
    form = HexletCode::Form.new model
    field_name = 'name'
    assert_raises(ArgumentError) { form.test_control field_name }
    assert_raises(ArgumentError) { form.test_control :name, 1 }
    assert_raises(ArgumentError) { form.test_control :name, field_name }
    assert_raises(ArgumentError) { form.test_control :name, nil }
  end
end
