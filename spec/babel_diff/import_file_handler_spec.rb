require 'spec_helper'

describe BabelDiff::ImportFileHandler do
  let(:import_directory) { "spec/test_files/imports" }
  let(:phrase_directory) { "config/locales" }
  subject(:handler) { BabelDiff::ImportFileHandler.new(import_directory, phrase_directory) }

  describe "#phrases" do
    before do
      initialize_project_with_some_translations
      `mkdir #{import_directory}/bad-lang`
      `touch #{import_directory}/bad-lang/untranslated_phrases.yml`
      `touch #{phrase_directory}/phrase.other-bad-lang.yml`
    end

    let(:expected_phrases) do
      {
        'es' => [es_phrase, es_import],
        'ru' => [ru_phrase, ru_import],
        'fr' => [fr_phrase, fr_import],
        'zh-CN' => [zh_CN_phrase, zh_CN_import],
        'pt-BR' => [pt_BR_phrase, pt_BR_import]
      }
    end

    let(:es_phrase) { File.read(phrase_directory + '/phrase.es.yml') }
    let(:ru_phrase) { File.read(phrase_directory + '/phrase.ru.yml') }
    let(:fr_phrase) { File.read(phrase_directory + '/phrase.fr.yml') }
    let(:zh_CN_phrase) { File.read(phrase_directory + '/phrase.zh-CN.yml') }
    let(:pt_BR_phrase) { File.read(phrase_directory + '/phrase.pt-BR.yml') }

    let(:es_import) { File.read(import_directory + '/es/untranslated_phrases.yml') }
    let(:ru_import) { File.read(import_directory + '/ru/untranslated_phrases.yml') }
    let(:fr_import) { File.read(import_directory + '/fr/untranslated_phrases.yml') }
    let(:zh_CN_import) { File.read(import_directory + '/zh-CN/untranslated_phrases.yml') }
    let(:pt_BR_import) { File.read(import_directory + '/pt-BR/untranslated_phrases.yml') }

    it "returns each pair of translation files that exist in both directories" do
      expect(handler.phrases).to eq(expected_phrases)
    end
  end

  describe '#update_phrase' do
    let(:file) { double(:file) }
    let(:phrase_file) { "config/locales/phrase.sp.yml" }
    before do
      allow(File).to receive(:open).with(phrase_file, "w+").and_yield(file)
      allow(file).to receive(:write)
      handler.update_phrase("sp", 'contents')
    end
    it 'writes the contents to the file' do
      expect(file).to have_received(:write).with("contents")
    end
  end
end
