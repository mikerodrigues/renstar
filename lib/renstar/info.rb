module Renstar
  class Info
    def initialize(info_hash)
      @raw_hash = info_hash
      info_hash.each do |key, value|
        instance_variable_set("@" + key, value)
      end
    end

    def to_s
      @raw_hash.map do |key, value|
        APIClient.lookup(:info, key, value)
      end.join(",\n")
    end
  end
end
