# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end
  # Your code goes here...
  Tag.extend Tag

  def self.form_for(_model, url: '#')
    Tag.build('form', action: url, method: 'post') {} # rubocop:disable Lint/EmptyBlock
  end
end
