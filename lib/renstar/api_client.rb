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
      binding.pry
      return JSON.parse(response)
    end

    def post(endpoint, options = {})
      uri = URI(location + endpoint)
      response = Net::HTTP.post_form(uri, options)
      binding.pry
      return JSON.parse(response.body)
    end

    include Query
    include Control
    include Settings

    @api_ref = JSON.parse(File.read(File.join(__dir__, "./api_client/api.json")))
    def self.key_to_description(type, key)
       @api_ref.fetch(type, nil)&.fetch(key, nil)&.fetch('description', nil) || key
    end
    def self.value_to_formatted(type, key, value)
      formatted_value = if @api_ref.fetch(type, nil)&.fetch(key, nil)&.fetch('values', nil) == "raw" then
                          value
                        else
                          @api_ref.fetch(type, nil)&.fetch(key, nil)&.fetch('values', nil)&.fetch(value.to_s, nil) || value
                        end
    end

  end
end

