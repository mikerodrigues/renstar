# frozen_string_literal: true

require_relative '../api_object'

module Renstar
  module APIClient
    # Represents an installed sensor in the system
    # Returns the value of the sensor
    class Sensor < APIObject
      def pp
        puts human_readable('sensors')
      end
    end
  end
end
