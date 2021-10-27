require_relative '../api_client'
require_relative 'info'
module Renstar
  module APIClient
    module Query
      def info
        Info.new(get("query/info"))
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




