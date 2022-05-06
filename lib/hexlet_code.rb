# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :FieldsBuilder, 'hexlet_code/fields_builder'
  autoload :Form, 'hexlet_code/form.rb' 

  extend self # rubocop:disable Style/ModuleFunction

  attr_accessor :content_builder

  @content_builder = HexletCode::FieldsBuilder

  def form_for(model, **attrs)
    form_attrs = { url: '#', method: :post }.merge attrs
    form_attrs[:action] = form_attrs.delete :url
    Tag.build('form', **form_attrs) do
      yield content_builder.new(model) if block_given?
    end
  end
end
