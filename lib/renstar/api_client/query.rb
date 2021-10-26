module Renstar
  class APIClient
    module Query
      def info
        API.request("query/info")
      end

      def senors
        API.request("query/sensors")
      end

      def runtimes
        API.request("query/runtimes")
      end

      def alerts
        API.request("query/alerts")
      end
    end
  end
end




