# frozen_string_literal: true

require 'test_helper'

class TestHtmlControls < Minitest::Test
  def create_html_controls
    html_controls_class = Class.new
    html_controls_class.include HexletCode::HtmlControls
    html_controls_class.new
  end

  def html_controls
    @html_controls ||= create_html_controls
  end

  def test_label
    target = html_controls.label
    assert { target == '<label></label>' }
    target = html_controls.label HexletCode::FIELD_NAME_KEY => :field_name, HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<label for="field_name">field_value</label>' }
    target = html_controls.label attr1: :value1, attr2: :value2, HexletCode::FIELD_NAME_KEY => :field_name,
                                 HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<label attr1="value1" attr2="value2" for="field_name">field_value</label>' }
  end

  def test_text_input
    target = html_controls.text_input
    assert { target == '<input type="text">' }
    target = html_controls.text_input HexletCode::FIELD_NAME_KEY => :field_name,
                                      HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<input type="text" name="field_name" value="field_value">' }
    target = html_controls.text_input attr1: :value1, HexletCode::FIELD_NAME_KEY => :field_name,
                                      HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<input attr1="value1" type="text" name="field_name" value="field_value">' }
  end

  def test_submit
    target = html_controls.submit
    assert { target == '<input name="commit" value="Save" type="submit">' }
    target = html_controls.submit value: 'Save changes'
    assert { target == '<input name="commit" value="Save changes" type="submit">' }
    target = html_controls.submit type: :text, value: 'Save changes'
    assert { target == '<input name="commit" value="Save changes" type="submit">' }
  end

  def test_textarea
    target = html_controls.textarea
    assert { target == '<textarea cols="20" rows="40"></textarea>' }
    target = html_controls.textarea HexletCode::FIELD_NAME_KEY => :field_name,
                                    HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<textarea cols="20" rows="40" name="field_name">field_value</textarea>' }
    target = html_controls.textarea attr1: :value1, rows: 10, HexletCode::FIELD_NAME_KEY => :field_name,
                                    HexletCode::FIELD_VALUE_KEY => 'field_value'
    assert { target == '<textarea cols="20" rows="10" attr1="value1" name="field_name">field_value</textarea>' }
  end

  def test_form
    target = html_controls.form url: '#'
    assert { target == '<form action="#"></form>' }
    target = html_controls.form url: '#', method: :post
    assert { target == '<form method="post" action="#"></form>' }
  end
end
