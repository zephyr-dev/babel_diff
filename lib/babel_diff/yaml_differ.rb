require 'yaml'

module BabelDiff
  class YamlDiffer < Struct.new(:current_version, :previous_version)
    def updates
      process_difference unless @processed
      @processed = true

      HashFlattener.new(updates_hash).unflatten.to_yaml
    end

    def additions
      process_difference unless @processed
      @processed = true

      HashFlattener.new(additions_hash).unflatten.to_yaml
    end

    def process_difference
      current = HashFlattener.new(current_version_hash).flatten
      previous = HashFlattener.new(previous_version_hash).flatten

      current.each do |k,v|
        if ! previous.has_key?(k)
          additions_hash[k] = v
        elsif previous[k] != v
          updates_hash[k] = v
        end
      end
    end

    private

    def updates_hash
      @updated_hash ||= {}
    end

    def additions_hash
      @additions_hash ||= {}
    end

    def previous_version_hash
      YAML.load(previous_version) || {}
    end

    def current_version_hash
      YAML.load(current_version) || {}
    end
  end

end
