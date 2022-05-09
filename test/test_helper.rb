# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'
require 'minitest-power_assert'

require 'byebug'

User = Struct.new(:name, :job, :gender, keyword_init: true)

def assert_start_with_opening_tag(target, tag_name)
  assert target.start_with?("<#{tag_name}"), "#{target} should start with <#{tag_name}"
end

def assert_include_opening_tag(target, tag_name)
  assert target.include?("<#{tag_name}"), "#{target} should include <#{tag_name}"
end

def assert_include_closing_tag(target, tag_name)
  assert target.include?("</#{tag_name}>"), "#{target} should include </#{tag_name}>"
end

def assert_end_with_closing_tag(target, tag_name)
  assert target.end_with?("</#{tag_name}>"), "#{target} should end with </#{tag_name}>"
end

def assert_include_tag_attribute(target, attr_name, attr_value)
  assert target.include?("#{attr_name}=\"#{attr_value}\""), "#{target} should include #{attr_name}=\"#{attr_value}\""
end

def assert_include_tag(target, tag_name, **attrs)
  assert_include_opening_tag target, tag_name
  assert_include_closing_tag target, tag_name if block_given?
  attrs.each { |attr, value| assert_include_tag_attribute target, attr, value }
  return unless block_given?

  block_result = yield
  assert target.include?(block_result), "#{target} should include <#{block_result}"
end
