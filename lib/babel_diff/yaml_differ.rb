module BabelDiff
  class YamlDiffer < Struct.new(:current_version, :previous_version)
    def updates
      current_version_hash.each do |k, v|
        if v.is_a? Hash

        else

        end
      end
    end

    def additions

    end

    private

    def updates_hash
      @updated_hash ||= {}
    end

    def additions_hash
      @additions_hash ||= {}
    end

    def previous_version_hash
      YAML.load(previous_version)
    end

    def current_version_hash
      YAML.load(current_version)
    end
  end
end
