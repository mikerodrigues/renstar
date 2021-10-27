require_relative '../api_client'
module Renstar
  module APIClient
    module Query
      def info
        get("query/info")
      end

      def sensors
        get("query/sensors")
      end

      def runtimes
        get("query/runtimes")
      end

      def alerts
        get("query/alerts")
      end
    end
  end
end




