# frozen_string_literal: true

module HexletCode
  module Tag
    VOID_TAGS = %w[area base br col command embed ht img input keygen link meta param source track wbr hr].freeze

    private_constant :VOID_TAGS

    class << self
      def build(tag_name, **attrs)
        raise ArgumentError, 'Empty tag name' if tag_name.to_s.strip.empty?

        tag_parts = []
        tag_parts << tag_open(tag_name, **attrs)
        unless void_tag? tag_name
          tag_parts << yield if block_given?
          tag_parts << "</#{tag_name}>"
        end
        tag_parts.join
      end

      def tag_open(tag_name, **attrs)
        attrs_str = attrs.inject('') do |result, (k, v)|
          attr_str = v ? "#{k}=\"#{v}\"" : k.to_s
          "#{result} #{attr_str}"
        end
        "<#{tag_name}#{attrs_str}>"
      end

      def void_tag?(tag_name)
        VOID_TAGS.include? tag_name
      end

      private :tag_open, :void_tag?
    end
  end
end
