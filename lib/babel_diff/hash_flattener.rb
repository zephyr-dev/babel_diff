module BabelDiff
  class HashFlattener < Struct.new(:hash)
    def flat_hash
      @_flat_hash ||= {}
    end

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

    def unflatten
      {}.tap do |unflattened_hash|
        hash.each do |k,v|
          keys = k.split(".")
          current_hash = unflattened_hash

          keys[0...-1].each { |key| current_hash = current_hash[key] ||= {} }

          current_hash[keys.last] = v
        end
      end
    end
  end
end
