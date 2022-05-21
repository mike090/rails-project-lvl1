# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: 'Rob', job: 'hexlet'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_return_string_result
    assert_instance_of String, (
      HexletCode.form_for @user
    )
  end

  def test_form_for_return_form_tag
    target = HexletCode.form_for @user
    assert_start_with_opening_tag target, 'form'
    assert_end_with_closing_tag target, 'form'
    assert_include_tag_attribute target, 'action', '#'
    assert_include_tag_attribute target, 'method', 'post'
  end

  def test_form_for_process_url_param
    path = '/users'
    target =
      HexletCode.form_for @user, url: path
    assert_include_tag_attribute target, 'action', path
  end

  def test_hexlet_integration
    target = HexletCode.form_for @user do |form|
      form.input :name
      form.input :job, as: :text
      form.submit 'It works!'
    end
    assert_start_with_opening_tag target, 'form'
    assert_end_with_closing_tag target, 'form'
    assert_include_tag(target, 'label', for: 'name') { 'Name' }
    assert_include_tag target, 'input', name: 'name', type: 'text', value: @user.name
    assert_include_tag(target, 'label', for: 'job') { 'Job' }
    assert_include_tag(target, 'textarea', name: 'job') { 'hexlet' }
    assert_include_tag target, 'input', name: 'commit', type: 'submit', value: 'It works!'
  end

  def test_raises_if_field_absent
    assert_raises(NoMethodError) do
      HexletCode.form_for @user do |form|
        form.input :age
      end
    end
  end
end
