module ElementFactory
  module Elements
    class TextElement
      attr_accessor :string

      def initialize(string)
        @string = string
      end

      def to_html
        ERB::Util.h(string)
      end
    end
  end
end