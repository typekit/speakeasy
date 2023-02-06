require File.dirname(__FILE__) + "/spec_helper"

describe "A Language" do
  SupportedLanguages = 55

  it "can list the supported language ids" do
    Speakeasy::Language.supported_language_ids.size.should == SupportedLanguages
  end

  it "can get all supported languages" do
    Speakeasy::Language.all.size.should == SupportedLanguages
  end

  it "can iterate over all supported languages" do
    Speakeasy::Language.each.to_a.size.should == SupportedLanguages
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
      subject.language_id.should == "de"
    end

    it "has codepoints" do
      subject.respond_to? :codepoints
      subject.codepoints.is_a? Array
    end

    it "has a native name" do
      subject.respond_to? :native_name
      subject.native_name.should == "Deutsch"
    end

    it "has a anglicized name" do
      subject.respond_to? :anglicized_name
      subject.anglicized_name.should == "German"
    end
  end
end
