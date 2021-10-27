require 'json'
require 'net/http'

require_relative 'api_client/query'
require_relative 'api_client/control'
require_relative 'api_client/settings'

module Renstar
  module APIClient

    def get(endpoint)
      uri = URI(location + endpoint)
      response = Net::HTTP.get(uri)
      return JSON.parse(response)
    end

    def post(endpoint, options = {})
      uri = URI(location + endpoint)
      response = Net::HTTP.post_form(uri, options)
      return JSON.parse(response)
    end

    include Query
    include Control
    include Settings

    @api_ref = JSON.parse(File.read("./api_client/api.json"))
    def lookup(type, key, value)
     return  @api_ref[type][key]['description']
    end

  end
end

