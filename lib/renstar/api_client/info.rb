module Renstar
  module APIClient
    class Info
      def initialize(info_hash)
        @raw_hash = info_hash
        info_hash.each do |key, value|
          instance_variable_set("@" + key, value)
        end
      end

      def to_h
        return @raw_hash
      end

      def pretty_summary
        @raw_hash.map do |key, value|
          description = APIClient.key_to_description("info", key)
          formatted_value = APIClient.value_to_formatted("info", key, value)
          sprintf("%-35s %s\n", description, formatted_value)
        end.join()
      end
    end
  end
end
