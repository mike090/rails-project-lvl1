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
    assert target.include_tag?('label', for: attribute_name) { attribute_name.to_s.capitalize }
    assert target.include_opening_tag? 'input'
    assert target.include_tag_attribute? 'name', attribute_name
    assert target.include_tag_attribute? 'type', 'text'
    assert target.include_tag_attribute? 'value', 'rob'
  end

  def test_input_return_textarea_tag # rubocop:disable Metrics/AbcSize
    attribute_name = :job
    target = @fields_builder.input attribute_name, as: :text
    assert target.include_tag?('label', for: attribute_name) { attribute_name.to_s.capitalize }
    assert target.include_opening_tag? 'textarea'
    assert target.include_tag_attribute? 'cols', 20
    assert target.include_tag_attribute? 'rows', 40
    assert target.include_tag_attribute? 'name', 'job'
    assert target.include? ">#{@user.job}<"
    assert target.include_closing_tag? 'textarea'
  end

  def test_input_raise_exception
    attribute_name = :age
    assert_raises(NoMethodError) { @fields_builder.input attribute_name }
  end

  def test_submit
    caption = 'Save changes'
    target = @fields_builder.submit caption
    assert target.include_opening_tag? 'input'
    assert target.include_tag_attribute? 'name', 'commit'
    assert target.include_tag_attribute? 'type', 'submit'
    assert target.include_tag_attribute? 'value', caption
  end
end
