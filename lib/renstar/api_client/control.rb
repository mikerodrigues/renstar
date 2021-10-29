# frozen_string_literal: true

require_relative '../api_client'
module Renstar
  module APIClient
    # Interface to the "Control" portion of the Venstar API
    # This can be used to send a hash of raw options to the API
    # bypassing the convenience methods built into `Thermostat`
    #
    module Control
      def control(options = {})
        post('control', options)
      end
    end
  end
end
