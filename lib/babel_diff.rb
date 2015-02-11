require "babel_diff/version"

module BabelDiff
  def self.run(new_file = "config/locales/phrases.en.yml")
    updates = YamlDiffer.new(filepath1, filepath2).updates
    additions = YamlDiffer.new(filepath1, filepath2).additions
  end
end
