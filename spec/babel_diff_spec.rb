require 'spec_helper'

describe BabelDiff do
  it 'has a version number' do
    expect(BabelDiff::VERSION).not_to be nil
  end

  describe "running the command for the first time" do
    before do
      initialize_project_with_some_translations
      run_command
    end

    it "puts all of the keys in the additions file" do
      expect_to_see_everything_in_additions_file
    end

    it "generates an empty changes file" do
      expect_to_see_empty_changes_file
    end
  end

  describe "running the command after having run it before" do
    before do
      initialize_project_with_some_translations
      run_command
    end

    context "having made changes" do
      before { make_some_changes }

      it "generates a changes file with the changed keys" do
        expect_to_see_changes_in_changes_file
      end
    end

    context "having added keys" do
      before { add_some_keys }

      it "generates an additions file with the added keys" do
        expect_to_see_new_translations_in_additions_file
      end
    end
  end

  describe "initializing a config directory" do
    before do
      initialize_project_with_some_translations
      run_init_command
    end

    it "does not generate any new files" do
      expect_to_see_empty_changes_file
      expect_to_see_empty_additions_file
    end

    it "sets the 'last babel diffed' to the current commit" do
      make_some_changes
      run_command
      expect_to_see_new_translations_in_additions_file
      expect_to_see_changes_in_changes_file
    end
  end

  def initialize_project_with_some_translations
    `rm config/locales/*`
    `mkdir -p config/locales/`
    `cp spec/test_files/seed.yml config/locales/phrases.en.yml`
  end

  def run_command
    BabelDiff.run
  end

  def expect_to_see_everything_in_additions_file
    expect(File.read("config/locales/phrases.en.additions.yml")).to eq File.read('spec/test_files/seed.yml')
  end
end
