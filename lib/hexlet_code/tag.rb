# frozen_string_literal: true

module HexletCode
  module Tag
    extend self

    @block_flag = 0

    VOID_TAGS = %w[area base br col command embed ht img input keygen link meta param source track wbr].freeze

    private_constant :VOID_TAGS

    def build(tag_name, **attrs, &block)
      raise ArgumentError, 'Empty tag name' if tag_name.to_s.strip.empty?

      tag_parts = []
      tag_parts << tag_open(tag_name, **attrs)
      unless void_tag? tag_name
        tag_parts << execute_block(&block) if block_given?
        tag_parts << "</#{tag_name}>"
      end
      tag = tag_parts.join

      if @block_flag.positive?
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
      attrs_str = attrs.inject('') do |result, (k, v)|
        attr_str = v ? "#{k}=\"#{v}\"" : k.to_s
        "#{result} #{attr_str}"
      end
      "<#{tag_name}#{attrs_str}>"
    end

    def execute_block
      @block_flag += 1
      begin
        tmp_buffer = @block_buffer
        @block_buffer = nil
        block_result = yield
        block_result = @block_buffer if @block_buffer
      ensure
        @block_buffer = tmp_buffer
        @block_flag -= 1
      end
      block_result.instance_of?(String) ? block_result : nil
    end

    def void_tag?(tag_name)
      VOID_TAGS.include? tag_name
    end
  end
end
