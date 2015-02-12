module BabelDiff
  class YamlMerger < Struct.new(:original_contents, :flattened_contents_to_merge)

    def merged_yaml
      flat_original = HashFlattener.new(original_hash).flatten

      flat_original.merge!(contents_to_merge)
      HashFlattener.new(flat_original).unflatten.to_yaml
    end

    def original_hash
      YAML.load(original_contents)
    end

    def contents_to_merge
      YAML.load(flattened_contents_to_merge)
    end

  end
end
