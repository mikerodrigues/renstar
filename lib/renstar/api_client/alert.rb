# frozen_string_literal: true

module Renstar
  module APIClient
    class Alert 
      def initialize(alert_hash)
        @raw_hash = alert_hash
        alert_hash.each do |key, value|
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
          description = APIClient.key_to_description('alerts', key)
          formatted_value = APIClient.value_to_formatted('alerts', key, value)
          format("%-35<description>s %<formatted_value>s\n",
                 { description: description, formatted_value: formatted_value })
        end.join
      end
    end
  end
end
