# frozen_string_literal: true

require 'test_helper'

class TestHtmlControls < Minitest::Test
  def html_controls
    HexletCode::HtmlControls
  end

  def data_control
    @data_control ||= HexletCode::Controls::DataControl.new name: :control
  end

  def control
    @control ||= HexletCode::Controls::Control.new name: :control
  end

  def test_label
    target = html_controls.label(data_control.tap do |label|
      label.field_name = :job
      label.field_value = 'hexlet'
      label.attributes[:class] = 'form-label'
    end)
    assert { target == '<label class="form-label" for="job">Job</label>' }
  end

  def test_text_input1
    target = html_controls.text_input(data_control.tap do |input|
      input.field_name = :name
      input.field_value = 'Rob'
    end)
    assert { target == '<input type="text" name="name" value="Rob">' }
  end

  def test_text_input2
    target = html_controls.text_input(data_control.tap do |control|
      control.attributes[:attr1] = :value1
      control.field_name = :job
      control.field_value = :hexlet
    end)
    assert { target == '<input attr1="value1" type="text" name="job" value="hexlet">' }
  end

  def test_submit
    target = html_controls.submit(control.tap do |control|
      control.attributes[:value] = 'Save changes'
      control.attributes[:type] = :text
    end)
    assert { target == '<input name="commit" value="Save changes" type="submit">' }
  end

  def test_textarea1
    target = html_controls.textarea control
    assert { target == '<textarea cols="20" rows="40"></textarea>' }
    target = html_controls.textarea(data_control.tap do |input|
      input.field_name = :note
      input.field_value = 'Text'
    end)
    assert { target == '<textarea cols="20" rows="40" name="note">Text</textarea>' }
  end

  def test_textarea2
    target = html_controls.textarea(data_control.tap do |input|
      input.field_name = :field_name
      input.field_value = 'field_value'
      input.attributes[:attr1] = :value1
      input.attributes[:rows] = 10
    end)
    assert { target == '<textarea cols="20" rows="10" attr1="value1" name="field_name">field_value</textarea>' }
  end

  def test_form
    target = html_controls.form HexletCode::Controls::FormControl.new
    assert { target == '<form method="post" action="#"></form>' }
    target = html_controls.form(HexletCode::Controls::FormControl.new.tap do |form|
      form.attributes[:url] = '/users'
      form.attributes[:method] = :put
    end)
    assert { target == '<form method="put" action="/users"></form>' }
  end
end
