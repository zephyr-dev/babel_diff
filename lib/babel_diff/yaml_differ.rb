require 'yaml'
require 'pry'

module BabelDiff
  class YamlDiffer < Struct.new(:current_version, :previous_version)
    def updates
      process_difference(current_version_hash) unless @processed
      @processed = true
      updates_hash.to_yaml
    end

    def additions
      process_difference(current_version_hash) unless @processed
      @processed = true
      additions_hash.to_yaml
    end

    def process_difference(current_hash, keys = [])
      current_hash.each do |key, value|
        keys << key
        if value.is_a? Hash
          process_difference(value, keys)
        else
          case in_previous_version(keys, value)
          when :does_not_exist
            add_key_to_additions(keys, value)
          when :value_different
            add_key_to_updates(keys, value)
          end
        end
        keys.pop
      end
    end

    def in_previous_version(keys, value)
      current_value = previous_version_hash
      keys.each do |key|
        current_value = current_value[key]
        return :does_not_exist if current_value.nil?
      end
      return :value_different if current_value != value
    end

    def add_key_to_updates(keys, value)
      current_value = updates_hash
      keys[0...-1].each do |key|
        current_value = current_value[key] ||= {}
      end
      current_value[keys.last] = value
    end

    def add_key_to_additions(keys, value)
      current_value = additions_hash
      keys[0...-1].each do |key|
        current_value = current_value[key] ||= {}
      end
      current_value[keys.last] = value
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
