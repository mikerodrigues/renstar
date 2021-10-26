module Renstar
  class APIClient
    module Query
      def info
        APIClient.request("query/info")
      end

      def senors
        APIClient.request("query/sensors")
      end

      def runtimes
        APIClient.request("query/runtimes")
      end

      def alerts
        APIClient.request("query/alerts")
      end
    end
  end
end




