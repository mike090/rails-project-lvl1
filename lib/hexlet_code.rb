# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/fields_builder'

module HexletCode
  class Error < StandardError; end
  extend self # rubocop:disable Style/ModuleFunction

  attr_accessor :content_builder

  @content_builder = HexletCode::FieldsBuilder

  def form_for(model, url: '#', &block)
    Tag.build('form', action: url, method: 'post') do
      block.call content_builder.new(model) if block_given?
    end
  end
end
