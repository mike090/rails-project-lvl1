# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :Controls, 'hexlet_code/controls.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Rendering, 'hexlet_code/rendering.rb'
  autoload :Html, 'hexlet_code/html.rb'
  autoload :HtmlControls, 'hexlet_code/html_controls.rb'

  require 'hexlet_code/input'

  class << self
    def form_for(model, **attrs)
      form = Form.new model, **attrs
      yield form if block_given?
      Rendering.render_control form
    end

    def register_html_controls
      HtmlControls.singleton_methods.each do |method_name|
        Rendering.register_renderer method_name, (HtmlControls.method method_name).to_proc
      end
    end

    private :register_html_controls
  end

  register_html_controls
end
