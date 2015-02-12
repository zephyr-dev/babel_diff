require 'spec_helper'

describe BabelDiff::YamlDiffer do
  let(:current_version) { File.read("spec/test_files/updated_file.yml") }
  let(:previous_version) { File.read("spec/test_files/locales/phrase.en.yml") }
  subject(:differ) { BabelDiff::YamlDiffer.new(current_version, previous_version) }

  describe '#updates' do
    let(:expected_updates) { File.read("spec/test_files/expected_files/expected_updates.yml")}
    it "returns a yaml string representing the updated keys" do
      expect(differ.updates).to eq(expected_updatesjjj)
    end
  end

  describe '#additions' do
    let(:expected_additions) { File.read("spec/test_files/expected_files/expected_additions.yml") }
    it "returns a yaml string representing the new keys" do
      expect(differ.additions).to eq(expected_additions)
    end
  end
end
