require 'pry'
module BabelDiff
  class ImportFileHandler < Struct.new(:import_directory, :phrase_directory)

    def phrases
      phrase_files = Dir.glob(phrase_directory + '/*.yml').map {|f| PhraseFile.new(f) }
      import_files = Dir.glob(import_directory + '/*/*.yml').map {|f| ImportFile.new(f) }

      matched_files = {}

      phrase_files.each do |phrase|
        if matched_import = import_files.detect {|i| i.language == phrase.language }
          matched_files[phrase.language] = [phrase.contents, matched_import.contents]
        end
      end

      matched_files
    end

    def update_phrase(language, contents)
      File.open(phrase_directory + "/phrase.#{language}.yml", "w+") do |file|
        file.write(contents)
      end
    end

    class PhraseFile < Struct.new(:path)

      def language
        path.split("/").last.match(/phrase.(.*).yml/)[1]
      end

      def contents
        File.read(path)
      end

    end

    class ImportFile < Struct.new(:path)

      def language
        path.split("/")[-2]
      end

      def contents
        File.read(path)
      end

    end


  end
end
