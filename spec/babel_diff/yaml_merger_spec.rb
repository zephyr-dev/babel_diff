require 'spec_helper'

describe BabelDiff::YamlMerger do

  describe "#merged_yaml" do

    let(:expected_merged_yaml) { YAML.load File.read("spec/test_files/expected_files/phrase.es.yml") }
    let(:phrase) { File.read("spec/test_files/locales/phrase.es.yml") }
    let(:new_content) { File.read("spec/test_files/imports/es/untranslated_phrases.yml") }
    subject(:merger) { BabelDiff::YamlMerger.new(phrase,new_content) }

    it "returns the newly merged yaml contents" do
      expect(YAML.load merger.merged_yaml).to eq(expected_merged_yaml)
    end
  end

end
