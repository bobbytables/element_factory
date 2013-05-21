module ElementFactory
  class Element
    attr_accessor :name, :attributes

    CONTENT_ATTRIBUTES = {text: Elements::TextElement, inner_html: Elements::InnerHtmlElement}

    def initialize(name, attributes_or_string=nil)
      @name = name.to_s
      @attributes = coerce_attributes(attributes_or_string)

      CONTENT_ATTRIBUTES.each do |attribute, klass|
        if value = attributes[attribute]
          add_child klass.new(value)
          attributes.delete(attribute)
        end
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
      (%|<%s%s>| % [name, tag_attributes]).html_safe
    end

    def tag_end
      (%|</%s>| % name).html_safe
    end

    def tag_middle
      (children.map(&:to_html).join).html_safe
    end

    private

    def coerce_attributes(attributes)
      case attributes
      when String then {text: attributes}
      when Hash then attributes
      else
        {}
      end
    end
  end
end