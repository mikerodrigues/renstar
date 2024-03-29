# frozen_string_literal: true

require_relative '../api_object'

module Renstar
  module APIClient
    # Represents an Alert in venstar
    # These alerts are for Air filter, Service, and UV Lamp
    #
    class Alert < APIObject
      def pp
        puts human_readable('alerts')
      end
    end
  end
end
