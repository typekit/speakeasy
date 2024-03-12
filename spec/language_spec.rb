require File.dirname(__FILE__) + "/spec_helper"

describe "A Language" do
  SupportedLanguages = 64

  it "can list the supported language ids" do
    expect(Speakeasy::Language.supported_language_ids.size).to eq(SupportedLanguages)
  end

  it "can get all supported languages" do
    expect(Speakeasy::Language.all.size).to eq(SupportedLanguages)
  end

  it "can iterate over all supported languages" do
    expect(Speakeasy::Language.each.to_a.size).to eq(SupportedLanguages)
  end

  it "contains valid code point ranges" do
    Speakeasy::Language.each do |lang|
      codepoints = lang.instance_variable_get(:@data)["codepoints"]

      codepoints.each do |c|
        if c.is_a?(Range)
          expect(c.to_a).not_to be_empty
        end
      end
    end
  end

  context "(German)" do
    subject do
      Speakeasy::Language.new("de")
    end

    it "has a language_id" do
      expect(subject.language_id).to eq("de")
    end

    it "has codepoints" do
      subject.respond_to? :codepoints
      subject.codepoints.is_a? Array
    end

    it "has a native name" do
      subject.respond_to? :native_name
      expect(subject.native_name).to eq("Deutsch")
    end

    it "has a anglicized name" do
      subject.respond_to? :anglicized_name
      expect(subject.anglicized_name).to eq("German")
    end
  end
end
