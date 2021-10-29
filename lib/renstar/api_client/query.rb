# frozen_string_literal: true

require_relative '../api_client'
require_relative 'info'
module Renstar
  module APIClient
    # Interface to the "Query" portion of the API
    # This can get general info, settings, runtime data, and alerts
    module Query
      def info
        Info.new(get('query/info'))
      end

      def sensors
        get('query/sensors')
      end

      def runtimes
        get('query/runtimes')
      end

      def alerts
        get('query/alerts')
      end
    end
  end
end
