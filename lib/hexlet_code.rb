# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Rendering, 'hexlet_code/rendering.rb'
  autoload :HtmlControls, 'hexlet_code/html_controls.rb'
  autoload :ControlData, 'hexlet_code/control.rb'
  autoload :Controls, 'hexlet_code/controls.rb'
  autoload :Forwardable, 'forwardable'
  autoload :Html, 'hexlet_code/html.rb'

  require 'hexlet_code/input'

  FORM_CONTROLS_KEY = '@controls'

  def self.register_html_controls
    HtmlControls.singleton_methods.each do |method_name|
      Rendering.register_control method_name, (HtmlControls.method method_name).to_proc
    end
  end

  def self.form_for(model, **attrs)
    form = Form.new model, **attrs
    yield form if block_given?
    Rendering.render_control Controls.create_control(**form.data)
  end

  register_html_controls
end
