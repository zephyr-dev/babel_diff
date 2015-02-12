require 'spec_helper'

describe BabelDiff do
  it 'has a version number' do
    expect(BabelDiff::VERSION).not_to be nil
  end

  describe "diffs" do
    describe "running the command for the first time" do
      before do
        initialize_project_with_some_translations
        run_diff_command
      end

      it "puts all of the keys in the additions file" do
        expect_to_see_everything_in_additions_file
      end

      it "generates an empty updates file" do
        expect_to_see_empty_updates_file
      end
    end

    describe "running the command after having run it before" do
      before do
        initialize_project_with_some_translations
        run_diff_command
        make_some_updates
        run_diff_command
      end


      it "generates a updates file with the changed keys" do
        expect_to_see_updates_in_updates_file
      end

      it "generates an additions file with the added keys" do
        expect_to_see_new_translations_in_additions_file
      end
    end
  end

  describe "importing translations" do
    before do
      initialize_project_with_some_translations
      run_import_command
    end

    it "merges the a flattened translation files with the appropriate phrase files" do
      expect_to_see_updated_phrase_files
    end
  end
end
