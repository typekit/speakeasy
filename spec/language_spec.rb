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
      0x007E, 0x00A4, 0x00A6, 0x00A7, 0x00A9, 0x00AE,
      0x00B0, 0x00B1, 0x00B6, 0x0FD5, 0x2010, 0x2032,
      0x2033, 0x2122, 0x2212, 0x2248, 0x2260, 0x11FE9
    ]
    Speakeasy::Language.each do |language|
      expect(language.codepoints & excluded).to be_empty, language.language_id
    end
  end

  it "preserves the existing legacy Adlam per-mille requirement" do
    expect(Speakeasy::Language.new("ff-Adlm").codepoints).to include(0x2030)
  end

  it "restores Bengali legacy forms without relaxing punctuation or currency" do
    codepoints = Speakeasy::Language.new("bn").codepoints
    expect(codepoints).to include(0x09CB, 0x09CC, 0x09DC, 0x09DD, 0x09DF)
    expect(codepoints).to include(0x00B7, 0x0964, 0x0965, 0x09F2, 0x09F3, 0x09FA, 0x09FD, 0x20B9)
  end

  it "preserves Persian legacy requirements without requiring ornate parentheses" do
    codepoints = Speakeasy::Language.new("fa").codepoints
    expect(codepoints).to include(
      0x0622, 0x0629, 0x064B, 0x064C, 0x064D, 0x064E, 0x064F,
      0x0650, 0x0651, 0x0652, 0x0654, 0x0670, 0x2039, 0x203A, 0xFDFC
    )
    expect(codepoints & [0xFD3E, 0xFD3F]).to be_empty
  end

  it "excludes Gurmukhi abbreviation without relaxing other reviewed requirements" do
    codepoints = Speakeasy::Language.new("Guru").codepoints
    expect(codepoints).not_to include(0x0A76)
    expect(codepoints).to include(0x0A05, 0x0A74, 0x00B7, 0x0964, 0x0965, 0x20B9)
  end

  it "preserves Urdu legacy forms and rupee without ornate parentheses or date separator" do
    codepoints = Speakeasy::Language.new("ur").codepoints
    expect(codepoints).to include(
      0x0622, 0x0623, 0x0624, 0x0626, 0x0629,
      0x0647, 0x06C2, 0x06D2, 0x06D4, 0x20A8
    )
    expect(codepoints & [0x060D, 0xFD3E, 0xFD3F]).to be_empty
    expect(Speakeasy::Language.new("ar").codepoints).to include(0xFD3E, 0xFD3F)
  end

  it "preserves Odia legacy forms without requiring hyphen-minus or trademark" do
    codepoints = Speakeasy::Language.new("or").codepoints
    expect(codepoints).to include(
      0x0B0C, 0x0B3D, 0x0B44, 0x0B48, 0x0B4B,
      0x0B4C, 0x0B5C, 0x0B5D, 0x0B62, 0x0B63
    )
    expect(codepoints & [0x002D, 0x2122]).to be_empty
    expect(Speakeasy::Language.new("en").codepoints).to include(0x002D)
  end

  it "requires Japanese Kanji alongside Hiragana and Katakana" do
    codepoints = Speakeasy::Language.new("ja").codepoints
    expect(codepoints).to include(0x65E5, 0x672C, 0x8A9E, 0x3042, 0x30A2)
    expect(codepoints).to include(0x3001, 0x3002, 0x300C, 0x300D, 0x300E, 0x300F)
    expect(codepoints).to include(0x0022, 0x0027, 0x002D, 0x005F, 0x30FB)
    excluded = [
      0x00A9, 0x00AB, 0x00AE, 0x00B7, 0x00BB, 0x0305, 0x2013,
      0x2014, 0x2016, 0x2022, 0x2039, 0x203A, 0x203E, 0x2122,
      0x301C, 0x30A0, 0x30F7, 0x30F8, 0x30F9, 0x30FA,
      0xFF02, 0xFF07, 0xFF0D, 0xFF3F, 0xFF61, 0xFF62, 0xFF63, 0xFF64, 0xFF65
    ]
    expect(codepoints & excluded).to be_empty
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
