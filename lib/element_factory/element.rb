module ElementFactory
  class Element
    attr_accessor :name, :attributes

    def initialize(name, attributes_or_string=nil)
      @name = name.to_s
      @attributes = coerce_attributes(attributes_or_string)

      if attributes[:text].is_a?(String)
        add_child Elements::TextElement.new(attributes[:text])
      end
    end

    def to_html
      tag_start + tag_middle + tag_end
    end
    alias to_s to_html

    def html_attributes
      HtmlAttributes.new(self.attributes.dup)
    end

    def add_child(child)
      children << child
    end
    alias << add_child

    def add_children(children)
      children.each {|child| add_child(child) }
    end

    def children
      @children ||= []
    end

    def tag_start
      tag_attributes = attributes.any?? " #{html_attributes}" : ""
      %|<%s%s>| % [name, tag_attributes]
    end

    def tag_end
      %|</%s>| % name
    end

    def tag_middle
      children.map(&:to_html).join
    end

    private

    def coerce_attributes(attributes)
      case attributes
      when String
        {text: attributes}
      when Hash
        attributes
      else
        {}
      end
    end
  end
end