# frozen_string_literal: true

module Renstar
  module APIClient
    # An abstraction to the info hash that gets returned from the API
    # It defines getters and instance variables for each key/value pair in the
    # info response from the API for clean access.
    #
    class Info
      def initialize(info_hash)
        @raw_hash = info_hash
        info_hash.each do |key, value|
          instance_variable_set("@#{key}", value)
          define_singleton_method(key) do
            return instance_variable_get("@#{key}")
          end
        end
      end

      def to_h
        @raw_hash
      end

      def pretty_summary
        @raw_hash.map do |key, value|
          description = APIClient.key_to_description('info', key)
          formatted_value = APIClient.value_to_formatted('info', key, value)
          format("%-35s %s\n", description, formatted_value)
        end.join
      end
    end
  end
end
