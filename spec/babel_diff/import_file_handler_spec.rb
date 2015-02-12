require 'spec_helper'

describe BabelDiff::FileHandler do
  describe "#phrases" do
    let(:import_directory) { "spec/test_files/imports" }
    let(:phrase_directory) { "config/locales" }
    
    before do
      initialize_project_with_some_translations
      `touch #{import_directory}/
      allow(Dir).to receive(:glob).with(import_directory)
    end
    it "returns each pair of translation files that exist in both directories" do
      expect(handler.phrases).to eq([[phrase1import,phrase1file],[phrase2import,phrase2file]])
    end
  end
end
