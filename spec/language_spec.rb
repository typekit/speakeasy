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

  it "excludes spacing circumflex and generic middle dot but preserves Catalan and Greek" do
    preserved = %w[HK IPA Phag ff-Adlm khb km nqo panafrican shi so-Osma tdd zh-Hans zh-Hant]
    Speakeasy::Language.each do |language|
      next if preserved.include?(language.language_id)
      expect(language.codepoints).not_to include(0x005E), language.language_id
      if %w[ca el].include?(language.language_id)
        expect(language.codepoints).to include(0x00B7), language.language_id
      else
        expect(language.codepoints).not_to include(0x00B7), language.language_id
      end
    end
    expect(Speakeasy::Language.new("fr").codepoints).to include(0x00E2, 0x00EA, 0x00F4)
  end

  it "restores Arabic letters and marks without requiring tatweel or ornate parentheses" do
    codepoints = Speakeasy::Language.new("ar").codepoints
    expect(codepoints).to include(
      0x0622, 0x0623, 0x0624, 0x0625, 0x0626, 0x0649, 0x064B,
      0x064C, 0x064D, 0x0651, 0x0653, 0x0654, 0x0655
    )
    expect(codepoints & [0x0640, 0xFD3E, 0xFD3F]).to be_empty
    expect(codepoints).to include(
      0x0028, 0x0029, 0x0030, 0x0039, 0x060C, 0x061B, 0x061F,
      0x0660, 0x0669, 0x066A, 0x066B, 0x066C, 0x066D, 0x0670
    )
  end

  it "restores Bengali legacy forms without relaxing punctuation or currency" do
    codepoints = Speakeasy::Language.new("bn").codepoints
    expect(codepoints).to include(0x09CB, 0x09CC, 0x09DC, 0x09DD, 0x09DF)
    expect(codepoints).to include(0x0964, 0x0965, 0x09F2, 0x09F3, 0x09FA, 0x09FD, 0x20B9)
  end

  it "requires Burmese core characters, digits and punctuation without Sanskrit extensions" do
    codepoints = Speakeasy::Language.new("my").codepoints
    expect(codepoints).to include(0x101F, 0x1020, 0x1021, 0x102E, 0x103F, 0x104F)
    expect(codepoints).to include(*(0x1040..0x104B).to_a)
    expect(codepoints & [0x1022, 0x1028, 0x1033, 0x1034, 0x1035, 0x1056, 0x1057]).to be_empty
  end

  it "excludes Greek punctuation aliases but retains their preferred encodings" do
    codepoints = Speakeasy::Language.new("el").codepoints
    expect(codepoints & [0x037E, 0x0387]).to be_empty
    expect(codepoints).to include(0x003B, 0x00B7, 0x20AC)
  end

  it "preserves Kazakh legacy quotation marks and tenge" do
    codepoints = Speakeasy::Language.new("kk").codepoints
    expect(codepoints).to include(0x00AB, 0x00BB, 0x20B8)
  end

  it "restores Malayalam O and OO without requiring historical AU" do
    codepoints = Speakeasy::Language.new("ml").codepoints
    expect(codepoints).to include(0x0D4A, 0x0D4B)
    expect(codepoints).not_to include(0x0D4C)
    expect(codepoints).to include(0x0964, 0x0965, 0x0D57, 0x0D66, 0x0D6F, 0x0D7A, 0x0D7F, 0x20B9)
  end

  it "restores encoded Lao AM without requiring HO NO or HO MO" do
    codepoints = Speakeasy::Language.new("lo").codepoints
    expect(codepoints).to include(0x0EB3, 0x0EB2, 0x0ECD, 0x20AD)
    expect(codepoints).not_to include(0x0EDC, 0x0EDD)
  end

  it "restores Thai PAIYANNOI and SARA AM without requiring auxiliary marks" do
    codepoints = Speakeasy::Language.new("th").codepoints
    expect(codepoints).to include(0x0E2F, 0x0E33, 0x0E32, 0x0E4D, 0x0E3F)
    expect(codepoints).not_to include(0x030D, 0x030E, 0x25CC)
  end

  it "restores Amharic core syllables while retaining upstream extensions and numerals" do
    codepoints = Speakeasy::Language.new("am").codepoints
    restored = [
      0x120F, 0x1217, 0x121F, 0x122F, 0x1237, 0x123F, 0x1267, 0x126F,
      0x1277, 0x127F, 0x1288, 0x1297, 0x129F, 0x12A7, 0x12DF, 0x12E7,
      0x12F7, 0x1307, 0x1327, 0x132F, 0x1337, 0x133F, 0x134F, 0x1357
    ] + (0x1220...0x1228).to_a + (0x1280...0x1287).to_a +
      (0x128A...0x128E).to_a + (0x12B8...0x12BF).to_a + (0x1340...0x1347).to_a
    expect(codepoints).to include(*restored)
    expect(codepoints).to include(0x1250, 0x125D, 0x12C0, 0x12C5, 0x1369, 0x137C)
  end

  it "restores Sinhala core consonants and vowel signs without importing auxiliary characters" do
    codepoints = Speakeasy::Language.new("si").codepoints
    restored = [0x0D82, 0x0D83, 0x0DCA, 0x0DD6, 0x0DF2] +
      (0x0D9A...0x0DA6).to_a + (0x0DCF...0x0DD5).to_a + (0x0DD8...0x0DE0).to_a
    expect(codepoints).to include(*restored)
    expect(codepoints).to include(0x0D8E)
    expect(codepoints).not_to include(0x0D8F, 0x0D90, 0x0DA6, 0x0DF3, 0x200C, 0x200D, 0x20B9)
  end

  it "restores Hindi candra characters without expanding other requirements" do
    codepoints = Speakeasy::Language.new("hi").codepoints
    expect(codepoints).to include(0x090D, 0x0911, 0x0945, 0x0949)
    expect(codepoints).not_to include(0x090C, 0x0933, 0x0950, 0x20B9)
    expect(codepoints).to include(0x093D, 0x0964, 0x0965)
  end

  it "restores Marathi legacy vowels without relaxing joiners, punctuation or currency" do
    codepoints = Speakeasy::Language.new("mr").codepoints
    expect(codepoints).to include(0x090C, 0x0911, 0x0945, 0x0949)
    expect(codepoints).to include(0x0964, 0x0965, 0x200C, 0x200D, 0x20B9)
  end

  it "restores reviewed Telugu forms without requiring historical LLLA" do
    codepoints = Speakeasy::Language.new("te").codepoints
    expect(codepoints).to include(0x0C3D, 0x0C48, 0x0C55)
    expect(codepoints).not_to include(0x0C34)
    expect(codepoints).to include(0x0964, 0x0965, 0x0C46, 0x0C56, 0x0C66, 0x0C6F, 0x20B9)
  end

  it "excludes the E pair only from Ukrainian without relaxing currency or apostrophes" do
    codepoints = Speakeasy::Language.new("uk").codepoints
    expect(codepoints & [0x042D, 0x044D]).to be_empty
    expect(codepoints).to include(0x0027, 0x2019, 0x20B4)
    %w[ru be].each do |identifier|
      expect(Speakeasy::Language.new(identifier).codepoints).to include(0x042D, 0x044D)
    end
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
    expect(codepoints).to include(0x0A05, 0x0A74, 0x0964, 0x0965, 0x20B9)
  end

  it "preserves Urdu legacy forms and rupee without ornate parentheses or date separator" do
    codepoints = Speakeasy::Language.new("ur").codepoints
    expect(codepoints).to include(
      0x0622, 0x0623, 0x0624, 0x0626, 0x0629,
      0x0647, 0x06C2, 0x06D2, 0x06D4, 0x20A8
    )
    expect(codepoints & [0x060D, 0xFD3E, 0xFD3F]).to be_empty
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
