# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: 'Rob'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_return_string_result
    assert_instance_of String, (
      HexletCode.form_for @user do |form| # rubocop:disable Lint/EmptyBlock
      end
    )
  end

  def test_form_for_return_form_tag
    target =
      HexletCode.form_for @user do |form| # rubocop:disable Lint/EmptyBlock
      end
    assert target.include_opening_tag? 'form'
    assert target.include_closing_tag? 'form'
    assert target.include_tag_attribute? 'action', '#'
    assert target.include_tag_attribute? 'method', 'post'
  end

  def test_form_for_process_url_param
    path = '/users'
    target =
      HexletCode.form_for @user, url: path do |form| # rubocop:disable Lint/EmptyBlock
      end
    assert target.include_tag_attribute? 'action', path
  end
end
