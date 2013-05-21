require "spec_helper"

describe ElementFactory::Element do
  subject { described_class.new(:table) }

  context "initializes" do
    subject { described_class }

    specify "with a tag" do
      tag = subject.new(:table)
      expect(tag.name).to eq("table")
    end

    specify "with attributes" do
      tag = subject.new(:table, {class: "something"})
      expect(tag.attributes).to have_key :class
      expect(tag.attributes[:class]).to eq("something")
    end

    specify "with a string" do
      tag = subject.new(:span, "Some text")
      expect(tag.children.first).to be_kind_of ElementFactory::Elements::TextElement
    end

    specify "with a string adds a child" do
      tag = subject.new(:span, "Some text")
      expect(tag).to have(1).children
    end

    it "accepts inner html" do
      tag = subject.new(:span, inner_html: "<p>I'm inside and safe!</p>".html_safe)
      expect(tag).to have_tag "p"
    end
  end

  context "tag pieces" do
    subject { described_class.new(:table) }

    context ".tag_start" do
      it "returns correct markup" do
        expect(subject.tag_start).to eq("<table>")
      end

      it "returns with attributes" do
        subject.attributes[:class] = "something"
        expect(subject.tag_start).to eq("<table class=\"something\">")
      end
    end
  end

  context ".html_attributes" do
    let(:attributes) { Hash.new }
    subject { described_class.new(:table) }
    before do
      ElementFactory::HtmlAttributes.
        should_receive(:new).
        and_return(attributes)
    end

    specify "are delegated" do
      expect(subject.html_attributes).to be attributes
    end
  end

  context ".to_html" do
    subject { described_class.new(:table, class: "a-class") }

    it "returns the tag" do
      expect(subject.to_html).to match /<table(.*)>(.*)<\/table>/
    end

    it "returns an html safe string" do
      expect(subject.to_html).to be_html_safe
    end

    it "returns the tag with attributes" do
      element = to_element(subject.to_html, "table")
      expect(element[:class]).to eq("a-class")
    end

    context "with children" do
      let(:child) { described_class.new(:tr) }
      before { subject << child }

      it "recusively renders all children of the node" do
        element = to_element(subject.to_html, "table")
        expect(element.at_css("tr")).to be_present
      end
    end

    context "with string children" do
      subject { described_class.new(:span, "Text") }

      it "includes a string node" do
        element = to_element(subject.to_html, "span")
        expect(element.text).to eq("Text")
      end
    end

    context "omitting attributes" do
      subject { described_class.new(:span, inner_html: "<p>Whut</p>") }

      it "does not include an inner_html attribute" do
        expect(subject).to_not have_xpath "//span[@inner_html]"
      end
    end
  end

  context "children" do
    let(:child) { described_class.new(:tr) }
    let(:children) { [described_class.new(:td),described_class.new(:td)] }

    context ".add_child" do
      it "adds a child element to the list" do
        expect { subject.add_child(child) }.to change(subject.children, :size).by(1)
      end
    end

    context ".add_children" do
      it "adds multiple chilren" do
        expect { subject.add_children(children) }.to change(subject.children, :size).by(2)
      end
    end
  end
end