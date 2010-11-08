require File.dirname(__FILE__) + "/spec_helper"

describe "A Language" do
  SupportedLanguages = 15

  it "can list the supported language ids" do
    Speakeasy::Language.supported_language_ids.size.should == SupportedLanguages
  end

  it "can iterate over all supported languages" do
    Speakeasy::Language.each.to_a.size.should == SupportedLanguages
  end

  context "(German)" do
    subject do
      Speakeasy::Language.new("de")
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
