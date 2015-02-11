module BabelDiff
  class FileHandler < Struct.new(:current_version_path)
    def previous_version
      File.exist?(previous_version_path) ? File.read(previous_version_path) : ""
    end

    def current_version
      if File.exist?(current_version_path)
        File.read(current_version_path)
      else
        raise "Phrase file not found"
      end
    end

    private

    def previous_version_path
      root_path + ".previous_version.yml"
    end

    def root_path
      current_version_path.split(".")[0...-1].join(".")
    end
  end
end
