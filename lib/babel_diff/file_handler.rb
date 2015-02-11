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

    def create_updates(content)
      File.open(updates_file_path, "w+") do |f|
        f.write(content)
      end
    end

    def create_additions(content)
      File.open(additions_file_path, "w+") do |f|
        f.write(content)
      end
    end

    def version_files
      current_contents = File.read(current_version_path)
      File.open(previous_version_path, "w+") do |f|
        f.write(current_contents)
      end
    end

    private

    def previous_version_path
      root_path + ".previous_version.yml"
    end

    def updates_file_path
      root_path + ".updates.yml"
    end

    def additions_file_path
      root_path + ".additions.yml"
    end

    def root_path
      current_version_path.split(".")[0...-1].join(".")
    end
  end
end
