module ElementFactory
  class Element
    attr_accessor :name, :attributes

    def initialize(name, attributes={})
      @name = name.to_s
      @attributes = attributes
    end

    def to_html
      tag_start + tag_middle + tag_end
    end

    def html_attributes
      attributes.map do |attribute, value|
        "#{attribute}=\"#{value}\""
      end.join(" ")
    end

    def add_child(child)
      children << child
    end
    alias << add_child

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
  end
end