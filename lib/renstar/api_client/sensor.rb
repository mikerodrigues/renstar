# frozen_string_literal: true

module Renstar
  module APIClient
    # Represents an installed sensor in the system
    # Returns the value of the sensor
    class Sensor
      def initialize(sensor_hash)
        @raw_hash = sensor_hash
        sensor_hash.each do |key, value|
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
          description = APIClient.key_to_description('sensors', key)
          formatted_value = APIClient.value_to_formatted('sensors', key, value)
          format("%-35<description>s %<formatted_value>s\n",
                 { description: description, formatted_value: formatted_value })
        end.join
      end
    end
  end
end