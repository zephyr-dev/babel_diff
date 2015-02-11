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

    it "generates an empty updates file" do
      expect_to_see_empty_updates_file
    end
  end

  describe "running the command after having run it before" do
    before do
      initialize_project_with_some_translations
      run_command
      make_some_updates
      run_command
    end


    it "generates a updates file with the changed keys" do
      expect_to_see_updates_in_updates_file
    end

    it "generates an additions file with the added keys" do
      expect_to_see_new_translations_in_additions_file
    end
  end

  def initialize_project_with_some_translations
    `rm config/locales/*`
    `mkdir -p config/locales/`
    `cp spec/test_files/seed.yml config/locales/phrases.en.yml`
  end

  def make_some_updates
    `cp spec/test_files/updated_file.yml config/locales/phrases.en.yml`
  end

  def run_command
    BabelDiff.run
  end

  def expect_to_see_everything_in_additions_file
    expect(additions_file).to eq seed_file
  end

  def expect_to_see_empty_updates_file
    expect(updates_file).to be_empty
  end

  def expect_to_see_updates_in_updates_file
    expect(updates_file).to eq expected_updates_file
  end

  def expect_to_see_new_translations_in_additions_file
    expect(additions_file).to eq(expected_additions_file)
  end




  def additions_file
    yaml_for_config_file("additions")
  end

  def updates_file
    yaml_for_config_file("updates")
  end

  def seed_file
    yaml_for_test_file("seed")
  end

  def expected_updates_file
    yaml_for_test_file("expected_updates")
  end

  def expected_additions_file
    yaml_for_test_file("expected_additions")
  end




  def yaml_for_test_file(name)
    YAML.load(File.read("spec/test_files/#{name}.yml"))
  end

  def yaml_for_config_file(name)
    YAML.load(File.read("config/locales/phrases.en.#{name}.yml"))
  end
end
