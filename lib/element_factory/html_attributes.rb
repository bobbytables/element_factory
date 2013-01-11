module ElementFactory
  class HtmlAttributes
    BOOLEAN_ATTRIBUTES = %w(disabled readonly multiple checked autobuffer
                           autoplay controls loop selected hidden scoped async
                           defer reversed ismap seemless muted required
                           autofocus novalidate formnovalidate open pubdate)

    attr_accessor :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def data_attributes
      (attributes[:data] || {}).each_with_object({}) do |(key,value), new_attributes|
        new_attributes["data-#{key.to_s.dasherize}"] = value
      end
    end

    def boolean_attributes
      attributes.each_with_object({}) do |(key, value), new_attributes|
        next unless BOOLEAN_ATTRIBUTES.include?(key.to_s)
        new_attributes[key] = key.to_s
      end
    end

    def to_s
      attributes = self.attributes
        .merge(data_attributes)
        .merge(boolean_attributes)
        .stringify_keys

      attributes.delete("data")

      attributes.keys.sort.map do |attribute|
        value = ERB::Util.html_escape(attributes[attribute])
        %(#{attribute}="#{value}")
      end.join(" ").html_safe
    end
  end
end