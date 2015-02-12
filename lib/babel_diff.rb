require "babel_diff/version"
require "babel_diff/file_handler"
require "babel_diff/yaml_differ"

module BabelDiff
  def self.generate_diffs(current_version_path = "config/locales/phrase.en.yml")
    handler = FileHandler.new(current_version_path)

    yaml_differ = YamlDiffer.new(handler.current_version, handler.previous_version)
    updates = yaml_differ.updates
    additions = yaml_differ.additions

    handler.create_updates(updates)
    handler.create_additions(additions)
    handler.version_files
  end

  def self.import_translations(import_directory, current_version_directory = "config/locales/")
    handler = ImportFileHandler.new(import_directory, current_version_directory)
    handler.each_phrase do |phrase, import|
      yaml_merger = YamlMerger.new(phrase, import)
      handler.update_phrase(yaml_merger.updated_phrase)
    end
  end

end
