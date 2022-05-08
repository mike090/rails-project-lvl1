# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def setup
    # @user = User.new name: 'Rob'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_return_string_result
    # assert_instance_of String, (
    #   HexletCode.form_for @user do |form| # rubocop:disable Lint/EmptyBlock
    #   end
    # )
  end

  def test_form_for_return_form_tag
    # target =
    #   HexletCode.form_for @user do |form| # rubocop:disable Lint/EmptyBlock
    #   end
    # assert_start_with_opening_tag target, 'form'
    # assert_end_with_closing_tag target, 'form'
    # assert_include_tag_attribute target, 'action', '#'
    # assert_include_tag_attribute target, 'method', 'post'
  end

  def test_form_for_process_url_param
    # path = '/users'
    # target =
    #   HexletCode.form_for @user, url: path do |form| # rubocop:disable Lint/EmptyBlock
    #   end
    # assert_include_tag_attribute target, 'action', path
  end

  def test_form_for_execute_block_with_field_builder
    # HexletCode.form_for @user do |form|
    #   assert_instance_of HexletCode::FieldsBuilder, form
    # end
  end

  def test_hexlet_integration
    # target = HexletCode.form_for @user do |form|
    #   form.input :name
    #   form.input :job
    #   form.submit
    # end
    # assert_start_with_opening_tag target, 'form'
    # assert_end_with_closing_tag target, 'form'
    # assert_include_tag(target, 'label', for: 'name') { 'Name' }
    # assert_include_tag target, 'input', name: 'name', type: 'text', value: @user.name
    # assert_include_tag(target, 'label', for: 'job') { 'Job' }
    # assert_include_tag target, 'input', name: 'job', type: 'text', value: @user.job
    # assert_include_tag target, 'input', name: 'commit', type: 'submit', value: 'Save'
  end
end
