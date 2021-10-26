require 'json'
require 'net/http'

require_relative 'api_client/query'

module Renstar
  class APIClient
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def request(endpoint)
      uri = URI(location + endpoint)
      response = HTTP.get(uri)
      return JSON.parse(response)
    end

    include Query
    include Control
    include Settings
  end
end

