$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'babel_diff'

def initialize_project_with_some_translations
  `rm config/locales/*`
  `mkdir -p config/locales/`
  `cp spec/test_files/seed.yml config/locales/phrase.en.yml`
end

def initialize_project_with_multiple_locales
  `rm config/locales/*`
  `mkdir -p config/locales/`
  `cp spec/test_files/seed.yml config/locales/phrase.en.yml`
  `cp spec/test_files/seed.yml config/locales/phrase.es.yml`
  `cp spec/test_files/seed.yml config/locales/phrase.fr.yml`
end



def make_some_updates
  `cp spec/test_files/updated_file.yml config/locales/phrase.en.yml`
end

def run_diff_command
  BabelDiff.generate_diffs
end

def run_import_command

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
  YAML.load(File.read("config/locales/phrase.en.#{name}.yml"))
end
