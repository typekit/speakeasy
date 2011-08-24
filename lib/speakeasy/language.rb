require 'yaml'

DATA_DIR = File.join(File.dirname(__FILE__), '..', '..', 'data')

module Speakeasy
  class Language
    # Public: Lists the supported IANA language codes.
    #
    # Returns an unordered array of all IANA language codes supported by the
    # current version of this gem.
    def self.supported_language_ids
      Dir.glob("#{DATA_DIR}/*").map do |file|
        File.basename(file)
      end
    end

    # Public: Iterates over all supported languages
    #
    # Returns an enumator over the list of supported languages
    def self.each(&block)
      languages = Dir.glob("#{DATA_DIR}/*").map do |file|
        Language.new(File.basename(file))
      end
      languages.each(&block)
    end

    def initialize(language_id)
      @language_id = language_id

      filename = File.join(DATA_DIR, language_id)

      unless File.exist? filename
        raise "The file describing this language doesn't exist in #{DATA_DIR}"
      end

      begin
        @data = YAML::load_file(filename)
      rescue
        raise "The language file is not a valid yaml file"
      end

      verify
    end

    # Public: Get the unique identifier of this language.
    #
    # Returns a String code.
    attr_reader :language_id

    # Public: Lists all unicode codepoints required by this language.
    #
    # It turns out that a required character is a difficult thing to define.
    # That said, this library will endevour to include the minimum
    # number of Unicode codepoints required to display a language. Punctuation
    # which is shared across multiple languages will not be included.
    #
    # Where regional dialects are too distinct, spliting of the languages by
    # IANA language subcode will be considered. However this is a last resort.
    #
    # Returns an unsorted array of integers representing Unicode codepoints.
    def codepoints
      @data["codepoints"].map { |v| Array(v) }.flatten
    end

    # Public: The English representation of this language's name
    #
    # Returns a UTF-8 string containing the English representation of this language's
    # name.
    def anglicized_name
      @data["anglicized_name"]
    end

    # Public: The name of the language in this language
    #
    # Returns a UTF-8 string containing the language's name in this language.
    def native_name
      @data["native_name"]
    end

  private
    def verify
      raise "No codepoints found" unless @data.has_key? "codepoints"
      raise "No anglicized language name found" unless @data.has_key? "anglicized_name"
      raise "No native language name found" unless @data.has_key? "native_name"

      raise "Incorrect version" unless @data.has_key? "version" and @data["version"] == 2
    end
  end
end
