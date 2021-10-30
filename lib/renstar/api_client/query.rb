# frozen_string_literal: true

require_relative '../api_client'
require_relative 'api_objects/info'
require_relative 'api_objects/sensor'
require_relative 'api_objects/runtime'
require_relative 'api_objects/alert'
module Renstar
  module APIClient
    # Interface to the "Query" portion of the API
    # This can get general info, settings, runtime data, and alerts
    module Query
      def info
        Info.new(get('query/info'))
      end

      def sensors
        get('query/sensors')['sensors'].map do |sensor|
          Sensor.new(sensor)
        end
      end

      def runtimes
        get('query/runtimes')['runtimes'].map do |runtime|
          Runtime.new(runtime)
        end
      end

      def alerts
        get('query/alerts')['alerts'].map do |alert|
          Alert.new(alert)
        end
      end
    end
  end
end
