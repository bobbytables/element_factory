require "element_factory/version"
require "active_support/core_ext/string"
require "active_support/core_ext/hash"

require "erb"

module ElementFactory
  autoload :Element, "element_factory/element"
  autoload :HtmlAttributes, "element_factory/html_attributes"

  module Elements
    autoload :TextElement, "element_factory/elements/text_element"
  end
end