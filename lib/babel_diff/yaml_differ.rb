require 'yaml'

module BabelDiff
  class YamlDiffer < Struct.new(:current_version, :previous_version)
    def updates
      process_difference unless @processed
      @processed = true

      unflatten(updates_hash).to_yaml
    end

    def additions
      process_difference unless @processed
      @processed = true

      unflatten(additions_hash).to_yaml
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

    def unflatten(hash)
      {}.tap do |unflattened_hash|
        hash.each do |k,v|
          keys = k.split(".")
          current_hash = unflattened_hash

          keys[0...-1].each { |key| current_hash = current_hash[key] ||= {} }

          current_hash[keys.last] = v
        end
      end
    end

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

  class HashFlattener < Struct.new(:hash)

    def flatten(current_hash = hash, keys = [])
      current_hash.each do |key, value|
        new_keys = keys.dup << key
        if value.is_a? Hash
          flatten(value, new_keys)
        else
          flat_hash[new_keys.join(".")] = value
        end
      end

      flat_hash
    end

    def flat_hash
      @_flat_hash ||= {}
    end
  end
end
