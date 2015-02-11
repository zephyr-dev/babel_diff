require "babel_diff/version"
require "babel_diff/file_handler"
require "babel_diff/yaml_differ"

module BabelDiff
  def self.run(current_file = "config/locales/phrases.en.yml")

    handler = FileHandler.new(current_file)

    yaml_differ = YamlDiffer.new(handler.current_file, handler.previous_version)
    updates = yaml_differ.updates
    additions = yaml_differ.additions

    handler.create_updates(updates)
    handler.create_additions(additions)
    handler.version_current_file

  end

end
