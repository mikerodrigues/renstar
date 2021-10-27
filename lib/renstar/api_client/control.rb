require_relative '../api_client'
module Renstar
  module APIClient
    module Control
      def control(options = {})
        post("control", options )
      end
    end
  end
end




