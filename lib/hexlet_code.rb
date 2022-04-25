# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/fields_builder'

module HexletCode
  class Error < StandardError; end
  # Your code goes here...
  Tag.extend Tag

  def self.form_for(model, url: '#', &block)
    Tag.build('form', action: url, method: 'post') do
      block.call HexletCode::FieldsBuilder.new(model) if block_given?
    end
  end
end
