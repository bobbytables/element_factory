module ElementFactory
  module Elements
    class InnerHtmlElement
      attr_accessor :inner_html

      def initialize(inner_html)
        @inner_html = inner_html
      end

      def to_html
        inner_html
      end
    end
  end
end