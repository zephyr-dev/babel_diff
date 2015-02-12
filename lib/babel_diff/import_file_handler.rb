module BabelDiff
  class ImportFileHandler < Struct.new(:import_directory, :phrase_directory)

    def phrases
      imports = Dir.glob(import_directory + '/*.yml')
      phrases = Dir.glob(phrase_directory + '/*.yml')
    end




  end
end
