# frozen_string_literal: true

module HexletCode
  module Tag
    def build(tag_name, **attrs, &block)
      raise ArgumentError if tag_name.strip.empty?

      "#{tag_open tag_name, **attrs}" \
        "#{execute_block(&block) if block_given?}" \
        "#{tag_close tag_name if block_given?}"
    end

    protected

    def tag_open(tag_name, **attrs)
      attr_str = attrs.inject('') { |str, (k, v)| "#{str} #{k}=\"#{v}\"" }
      "<#{tag_name}#{attr_str}>"
    end

    def execute_block(&block)
      block.call
    end

    def tag_close(tag_name)
      "</#{tag_name}>"
    end
  end
end
