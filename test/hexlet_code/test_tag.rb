# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def test_build_raise_exception_if_tag_name_blank
    assert_raises(
      ArgumentError,
      'Blank tag_name must raise exception'
    ) { HexletCode::Tag.build '   ' }
  end

  def test_build_returns_opening_tag
    tag_name = 'a'
    target = HexletCode::Tag.build(tag_name)
    assert_start_with_opening_tag target, tag_name
  end

  def test_build_executes_block
    block_flag = false
    HexletCode::Tag.build('div') { block_flag = true }
    assert block_flag, 'Block should be executed'
  end

  def test_closing_tag_absent
    target = HexletCode::Tag.build('img', src: '#', alt: 'image1')
    refute target.include?('</'), "Closing tag (</) should be absent in #{target}"
  end

  def test_tag_contains_substr_that_block_return
    block_result = 'block data'
    target = HexletCode::Tag.build('div') { block_result }
    assert target.include?(block_result), "#{target} must contain '#{block_result}'"
  end

  def test_tag_dnt_contains_non_string_reslt_of_block
    block_result = {}
    target = HexletCode::Tag.build('div') { block_result }
    assert_nil(
      target.slice('<div>').slice('</div>'),
      "#{target} shouldn't contain a non-string block result"
    )
  end

  def test_build_return_tag_attributes_from_hash_argument
    attrs = { type: 'submit', value: 'Save' }
    target = HexletCode::Tag.build('input', **attrs)
    attrs.each { |k, v| assert_include_tag_attribute target, k, v }
  end

  def test_hexlet_n1
    target = HexletCode::Tag.build 'br'
    assert_equal target, '<br>'
  end

  def test_hexlet_n2
    target = HexletCode::Tag.build('img', src: 'path/to/image')
    assert do
      target == '<img src="path/to/image">'
    end
  end

  def test_hexlet_n3
    target = HexletCode::Tag.build('input', type: 'submit', value: 'Save')
    assert do
      target == '<input type="submit" value="Save">'
    end
  end

  def test_hexlet_n4
    target = HexletCode::Tag.build('label') { 'Email' }
    assert do
      target == '<label>Email</label>'
    end
  end

  def test_hexlet_n5
    target = HexletCode::Tag.build('label', for: 'email') { 'Email' }
    assert do
      target == '<label for="email">Email</label>'
    end
  end

  def test_hexlet_n6
    target = HexletCode::Tag.build('div')
    assert do
      target == '<div></div>'
    end
  end
end
