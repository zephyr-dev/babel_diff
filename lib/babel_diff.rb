require "babel_diff/version"
require "babel_diff/file_handler"
require "babel_diff/import_file_handler"
require "babel_diff/yaml_differ"
require "babel_diff/yaml_merger"
require "babel_diff/hash_flattener"

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

  def self.import_translations(import_directory, phrase_directory = "config/locales")
    handler = ImportFileHandler.new(import_directory, phrase_directory)
    handler.phrases.each do |language,files|
      phrase, import = files
      yaml_merger = YamlMerger.new(phrase, import)
      handler.update_phrase(language,yaml_merger.merged_yaml)
    end
  end

end
