# frozen_string_literal: true

class String
  def include_opening_tag?(tag_name)
    start_with? "<#{tag_name}"
  end

  def include_closing_tag?(tag_name)
    end_with? "</#{tag_name}>"
  end

  def include_tag_attribute?(attr_name, attr_value)
    include? "#{attr_name}=\"#{attr_value}\""
  end
end
