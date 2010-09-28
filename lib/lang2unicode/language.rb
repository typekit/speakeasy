require 'yaml'

DATA_DIR = File.join(File.dirname(__FILE__), '..', '..', 'data')

module Lang2Unicode
  class Language
    def initialize(language)
      filename = File.join(DATA_DIR, language)

      unless File.exist? filename
        raise "The file describing this language doesn't exist in #{DATA_DIR}"
      end

      begin
        @data = YAML::load_file(filename)
      rescue
        raise "The language file is not a valid yaml file"
      end

      raise "No codepoints found" unless @data.has_key? "codepoints"
      raise "Incorrect version" unless @data.has_key? "version" and @data["version"] == 1
    end

    def codepoints
      @data["codepoints"].map { |v| v.to_a }.flatten
    end
  end
end
