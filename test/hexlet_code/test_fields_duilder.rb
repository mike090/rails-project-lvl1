# frozen_string_literal: true

require 'test_helper'

class TestFieldsBuilder < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    @fields_builder = HexletCode::FieldsBuilder.new @user
  end

  def test_input_return_input_tag
    attribute_name = :name
    target = @fields_builder.input attribute_name
    assert_include_tag(target, 'label', for: attribute_name) { attribute_name.to_s.capitalize }
    assert_include_tag target, 'input', name: attribute_name, type: 'text', value: 'rob'
  end

  def test_input_return_textarea_tag
    attribute_name = :job
    target = @fields_builder.input attribute_name, as: :text
    assert_include_tag(target, 'label', for: attribute_name) { attribute_name.to_s.capitalize }
    assert_include_tag(target, 'textarea', cols: 20, rows: 40, name: 'job') { @user.job }
  end

  def test_input_raise_exception
    attribute_name = :age
    assert_raises(NoMethodError) { @fields_builder.input attribute_name }
  end

  def test_submit
    caption = 'Save changes'
    target = @fields_builder.submit caption
    assert_include_tag target, 'input', name: 'commit', type: 'submit', value: caption
  end
end
