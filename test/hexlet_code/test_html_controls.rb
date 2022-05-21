# frozen_string_literal: true

require 'test_helper'

class TestHtmlControls < Minitest::Test
  def html_controls
    HexletCode::HtmlControls
  end

  def data_control(field_name)
    HexletCode::Controls::DataControl.new :data_control, field_name
  end

  def control
    HexletCode::Controls::Control.new :control
  end

  def test_label
    target = html_controls.label(data_control(:job).tap do |control|
      control.field_value = 'hexlet'
      control.attributes[:class] = 'form-label'
    end)
    assert { target == '<label class="form-label" for="job">Job</label>' }
  end

  def test_text_input1
    target = html_controls.text_input(data_control(:name).tap do |input|
      input.field_value = 'Rob'
    end)
    assert { target == '<input type="text" name="name" value="Rob">' }
  end

  def test_text_input2
    target = html_controls.text_input(data_control(:job).tap do |control|
      control.attributes[:attr1] = :value1
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
    target = html_controls.textarea(data_control(:note).tap do |input|
      input.field_value = 'Text'
      input.attributes[:attr1] = :value1
    end)
    assert { target == '<textarea cols="20" rows="40" attr1="value1" name="note">Text</textarea>' }
  end

  def test_form1
    target = html_controls.form HexletCode::Controls::FormControl.new User.new(name: 'Rob')
    assert { target == '<form method="post" action="#"></form>' }
    target = html_controls.form(HexletCode::Controls::FormControl.new(User.new(name: 'Rob')).tap do |form|
      form.attributes[:url] = '/users'
      form.attributes[:method] = :put
    end)
    assert do
      target == '<form method="put" action="/users"></form>'
    end
  end

  def test_form2
    target = html_controls.form(HexletCode::Controls::FormControl.new(User.new(name: 'Rob')).tap do |form|
      form.controls << HexletCode::Controls::DataControl.new(:text_input, :name)
      form.controls << HexletCode::Controls::Control.new(:submit)
    end)
    assert do
      target == '<form method="post" action="#"><input type="text" name="name" value="Rob">' \
                '<input name="commit" type="submit" value="Save"></form>'
    end
  end
end
