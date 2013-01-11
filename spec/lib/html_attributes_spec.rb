require "spec_helper"

describe ElementFactory::HtmlAttributes  do
  let(:attributes) { Hash.new }
  subject { described_class.new(attributes) }

  it "assigns attributes" do
    expect(subject.attributes).to eq(attributes)
  end

  context ".data_attributes" do
    it "returns keys with data prefix" do
      attributes[:data] = {key1: "value1"}
      expect(subject.data_attributes).to have_key "data-key1"
    end

    it "dasherizes the keys" do
      attributes[:data] = {key_1: "value"}
      expect(subject.data_attributes).to have_key "data-key-1"
    end
  end

  context ".boolean_attributes" do
    it "returns itself if true" do
      attributes[:disabled] = true
      expect(subject.boolean_attributes[:disabled]).to eq("disabled")
    end
  end

  context ".to_s" do
    it "returns attributes in markup form" do
      attributes[:class] = "a-class"
      attributes[:data] = {key: "val"}
      attributes[:disabled] = true

      expect(subject.to_s).to eq(%(class="a-class" data-key="val" disabled="disabled"))
    end

    it "escapes attribute values" do
      attributes[:class] = "<lawl> \""
      expect(subject.to_s).to eq(%(class="&lt;lawl&gt; &quot;"))
    end
  end
end