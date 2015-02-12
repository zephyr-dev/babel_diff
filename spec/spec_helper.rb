$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'babel_diff'

def initialize_project_with_some_translations
  `rm config/locales/*`
  `mkdir -p config/locales/`
  `cp spec/test_files/locales/* config/locales/`
end

def make_some_updates
  `cp spec/test_files/updated_file.yml config/locales/phrase.en.yml`
end

def run_diff_command
  BabelDiff.generate_diffs("config/locales/phrase.en.yml")
end

def run_import_command
  BabelDiff.import_translations("spec/test_files/imports", "config/locales/")
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

def expect_to_see_updated_phrase_files
  expect(spanish_file).to eq(expected_spanish_file)
  expect(french_file).to eq(expected_french_file)
  expect(russian_file).to eq(expected_russian_file)
  expect(chinese_file).to eq(expected_chinese_file)
  expect(portuguese_file).to eq(expected_portuguese_file)
end


def additions_file
  yaml_for_config_file("additions")
end

def updates_file
  yaml_for_config_file("updates")
end

def spanish_file
  language_file('es')
end

def french_file
  language_file('fr')
end

def russian_file
  language_file('ru')
end

def chinese_file
  language_file('zh-CN')
end

def portuguese_file
  language_file('pt-BR')
end

def seed_file
  language_file("en")
end

def expected_updates_file
  expected_file("expected_updates")
end

def expected_additions_file
  expected_file("expected_additions")
end


def expected_spanish_file
  expected_language_file("es")
end

def expected_french_file
  expected_language_file("fr")
end

def expected_russian_file
  expected_language_file("ru")
end

def expected_chinese_file
  expected_language_file("zh-CN")
end

def expected_portuguese_file
  expected_language_file("pt-BR")
end


def yaml_for_test_file(name)
  YAML.load(File.read("spec/test_files/#{name}.yml"))
end

def yaml_for_config_file(name)
  YAML.load(File.read("config/locales/phrase.en.#{name}.yml"))
end

def language_file(language)
  YAML.load(File.read("config/locales/phrase.#{language}.yml"))
end

def expected_language_file(language)
  expected_file("phrase.#{language}")
end

def expected_file(name)
  YAML.load(File.read("spec/test_files/expected_files/#{name}.yml"))
end
