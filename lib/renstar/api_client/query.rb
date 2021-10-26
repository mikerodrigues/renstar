require_relative '../api_client'
module Renstar
  class APIClient
    module Query
      def info
        request("query/info")
      end

      def senors
        request("query/sensors")
      end

      def runtimes
        request("query/runtimes")
      end

      def alerts
        request("query/alerts")
      end
    end
  end
end




