require_relative '../api_client'
module Renstar
  module APIClient
    module Settings
      def settings(options = {})
        post("settings", options )
      end
    end
  end
end




