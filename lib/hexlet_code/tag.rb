# frozen_string_literal: true

module HexletCode
  module Tag
    extend self

    @indent = 0

    def build(tag_name, **attrs, &block)
      raise ArgumentError if tag_name.strip.empty?

      tag = "#{tag_open tag_name, **attrs}" \
            "#{execute_block(&block) if block_given?}" \
            "#{tag_close tag_name if block_given?}"
      if @indent.positive?
        if @block_buffer
          @block_buffer.concat tag
        else
          @block_buffer = tag
        end
      end
      tag
    end

    private

    def tag_open(tag_name, **attrs)
      attr_str = attrs.inject('') { |str, (k, v)| "#{str} #{k}=\"#{v}\"" }
      "<#{tag_name}#{attr_str}>"
    end

    def execute_block(&block)
      @indent += 1
      begin
        tmp_buffer = @block_buffer
        @block_buffer = nil
        block_result = block.call
        block_result = @block_buffer if @block_buffer
      ensure
        @block_buffer = tmp_buffer
        @indent -= 1
      end
      block_result.instance_of?(String) ? block_result : nil
    end

    def tag_close(tag_name)
      "</#{tag_name}>"
    end
  end
end
