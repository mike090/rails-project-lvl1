# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def tag_subject
    HexletCode::Tag
  end

  def test_build_return_string_result
    target = tag_subject.build 'a'
    assert_instance_of String, target, "#{target} must be a string"
  end

  def test_build_raise_exception_if_tag_name_blank
    assert_raises(
      ArgumentError,
      'Blank tag_name must raise exception'
    ) { tag_subject.build '   ' }
  end

  def test_build_returns_opening_tag
    tag_name = 'a'
    target = tag_subject.build(tag_name)
    assert(
      target.include_opening_tag?(tag_name),
      "'#{target}' must start with '<#{tag_name}>'"
    )
  end

  def test_build_executes_block
    block_flag = false
    tag_subject.build('div') { block_flag = true }
    assert block_flag, 'Block should be executed'
  end

  def test_that_build_returns_closing_tag_if_block_given
    tag_name = 'div'
    target = tag_subject.build(tag_name) {} # rubocop:disable Lint/EmptyBlock
    assert(
      target.include_closing_tag?(tag_name),
      "'#{target}' should contain closing tag (</#{tag_name}>) if block passed"
    )
  end

  def test_closing_tag_absent
    target = tag_subject.build('img', src: '#', alt: 'image1')
    refute target.include?('</'), "Closing tag (</) should be absent in #{target}"
  end

  def test_tag_contains_substr_that_block_return
    block_result = 'block data'
    target = tag_subject.build('div') { block_result }
    assert target.include?(block_result), "#{target} must contain '#{block_result}'"
  end

  def test_tag_dnt_contains_non_string_reslt_of_block
    block_result = {}
    target = tag_subject.build('div') { block_result }
    assert_nil(
      target.slice('<div>').slice('</div>'),
      "#{target} must not contain a non-string block result"
    )
  end

  def test_build_return_tag_attributes_from_hash_argument
    attrs = { type: 'submit', value: 'Save' }
    target = tag_subject.build('input', **attrs)
    attrs.each { |k, v| assert target.include_tag_attribute?(k, v), "#{target} must contain '#{k}=\"#{v}\"'" }
  end

  def test_hexlet_n1
    target = tag_subject.build 'br'
    assert_equal target, '<br>'
  end

  def test_hexlet_n2
    target = tag_subject.build('img', src: 'path/to/image')
    assert(
      target.include?('<img src="path/to/image">')
    )
  end

  def test_hexlet_n3
    target = tag_subject.build('input', type: 'submit', value: 'Save')
    assert(
      target.include?('<input type="submit" value="Save">')
    )
  end

  def test_hexlet_n4
    assert_equal(
      tag_subject.build('label') { 'Email' },
      '<label>Email</label>'
    )
  end

  def test_hexlet_n5
    assert_equal(
      tag_subject.build('label', for: 'email') { 'Email' },
      '<label for="email">Email</label>'
    )
  end

  def test_hexlet_n6
    assert_equal tag_subject.build('div') {}, '<div></div>' # rubocop:disable Lint/EmptyBlock
  end
end
