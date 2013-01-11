require "spec_helper"

describe ElementFactory::Elements::TextElement do
  subject { described_class.new("Some text") }

  context ".to_html" do
    it "returns the text" do
      expect(subject.to_html).to eq("Some text")
    end

    it "escapes naughty things" do
      subject.string = "Some & Thing"
      expect(subject.to_html).to eq("Some &amp; Thing")
    end
  end
end