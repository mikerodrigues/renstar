# frozen_string_literal: true

module Renstar
  module APIClient
    # Base API Object class from which other objects inherit
    class APIObject
      def initialize(raw_hash)
        @raw_hash = raw_hash
        raw_hash.each do |key, value|
          if key == 'ts'
            instance_variable_set("@#{key}", Time.at(value))
          else
            instance_variable_set("@#{key}", value)
          end

          define_singleton_method(key) do
            return instance_variable_get("@#{key}")
          end
        end
      end

      def to_h
        @raw_hash
      end

      def human_readable
        @raw_hash.map do |key, value|
          description = APIClient.key_to_description('runtimes', key)
          formatted_value = APIClient.value_to_formatted('runtimes', key, value)
          format("%-35<description>s %<formatted_value>s\n",
                 { description: description, formatted_value: formatted_value })
        end.join
      end

      def pp
        puts human_readable
      end
    end
  end
end
