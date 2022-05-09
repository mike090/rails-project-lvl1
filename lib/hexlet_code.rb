# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Renderer, 'hexlet_code/renderer.rb'
  autoload :HtmlControls, 'hexlet_code/html_controls.rb'

  CONTROL_TYPE_KEY = :type
  CONTROL_ATTRS_KEY = :attributes
  FIELD_NAME_KEY = :field_name
  FIELD_VALUE_KEY = :field_value
  FORM_CONTROLS_KEY = '@controls'

  def self.register_html_controls
    HtmlControls.singleton_methods.each do |method_name|
      Renderer.register_control method_name, (HtmlControls.method method_name).to_proc
    end
  end

  # extend self

  attr_accessor :content_builder

  def form_for(model, **attrs)
    # form_attrs = { url: '#', method: :post }.merge attrs
    # form_attrs[:action] = form_attrs.delete :url
    # Tag.build('form', **form_attrs) do
    #   yield content_builder.new(model) if block_given?
    # end
  end

  register_html_controls
end
