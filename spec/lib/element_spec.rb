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
      subject.stub(:attributes).and_return(attributes)
    end

    it "returns an attributes in markup form" do
      attributes[:class] = "a-class"
      expect(subject.html_attributes).to eq("class=\"a-class\"")
    end
  end

  context ".to_html" do
    subject { described_class.new(:table, class: "a-class") }

    it "returns the tag" do
      expect(subject.to_html).to match /<table(.*)>(.*)<\/table>/
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
  end

  context ".add_child" do
    let(:child) { described_class.new(:tr) }
    it "adds a child element to the list" do
      expect { subject.add_child(child) }.to change(subject.children, :size).by(1)
    end
  end
end