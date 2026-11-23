require File.dirname(__FILE__) + "/spec_helper"

describe "A Language" do
  SupportedLanguages = 78

  it "can list the supported language ids" do
    expect(Speakeasy::Language.supported_language_ids.size).to eq(SupportedLanguages)
  end

  it "can get all supported languages" do
    expect(Speakeasy::Language.all.size).to eq(SupportedLanguages)
  end

  it "can iterate over all supported languages" do
    expect(Speakeasy::Language.each.to_a.size).to eq(SupportedLanguages)
  end

  it "does not require the globally excluded characters in any language" do
    excluded = [
      0x00A4, 0x00A6, 0x00B1, 0x0FD5, 0x2010, 0x2032,
      0x2033, 0x2212, 0x2248, 0x2260, 0x11FE9
    ]
    Speakeasy::Language.each do |language|
      expect(language.codepoints & excluded).to be_empty, language.language_id
    end
  end

  it "preserves the existing legacy Adlam per-mille requirement" do
    expect(Speakeasy::Language.new("ff-Adlm").codepoints).to include(0x2030)
  end

  it "excludes the old rupee only when modern Indian rupee coverage remains mandatory" do
    %w[Deva Guru bn gu kn ml mr ta te].each do |identifier|
      codepoints = Speakeasy::Language.new(identifier).codepoints
      expect(codepoints).to include(0x20B9)
      expect(codepoints).not_to include(0x20A8)
    end
    urdu = Speakeasy::Language.new("ur").codepoints
    expect(urdu).to include(0x20A8)
    expect(urdu).not_to include(0x20B9)
  end

  [
    ["da", [0x00C9, 0x00E9], [0x00D3, 0x00F3]],
    ["it", "JKWXYjkwxy".codepoints, [0x00EE, 0x00EF]]
  ].each do |identifier, required, optional|
    it "retains reviewed letters without requiring extended letters for #{identifier}" do
      codepoints = Speakeasy::Language.new(identifier).codepoints
      expect(codepoints).to include(*required)
      expect(codepoints & optional).to be_empty
    end
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

  context "(English)" do
    subject do
      Speakeasy::Language.new("en")
    end

    it "preserves version-2 YAML, readable ranges, and a minimal canonical source reference" do
      contents = File.read(File.join(DATA_DIR, "en"))
      expect(contents).to start_with("---\n")
      expect(contents).to include("- !ruby/range 33..47 # !")
      expect(contents).to include("- !ruby/range 65..90 # A,B,C")
      data = subject.instance_variable_get(:@data)
      expect(data["version"]).to eq(2)
      expect(data["codepoints"]).to include(65..90, 97..122)
      expect(data["parlance"].keys).to contain_exactly("schema_version", "definition_hash")
    end

    it "requires punctuation rather than classifying alphabet-only fonts as fully supported" do
      punctuation = [34, 39, 44, 46, 0x2018, 0x2019, 0x201C, 0x201D, 0x2026]
      expect(subject.codepoints).to include(*punctuation)
    end

    it "retains the existing uppercase and lowercase alphabet requirements" do
      expect(subject.codepoints).to include(*(65..90).to_a, *(97..122).to_a)
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

  [
    ["jv", "Javanese", "ꦧꦱꦗꦮ"],
    ["zh-Latn-pinyin", "Chinese Pinyin", "Hànyǔ Pīnyīn"]
  ].each do |identifier, english, native|
    it "preserves the selected orthography's names for #{identifier}" do
      language = Speakeasy::Language.new(identifier)
      expect(language.anglicized_name).to eq(english)
      expect(language.native_name).to eq(native)
    end
  end
end
