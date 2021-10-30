# frozen_string_literal: true

require 'json'
require 'net/http'

require_relative 'api_client/query'
require_relative 'api_client/control'
require_relative 'api_client/settings'

module Renstar
  # The actual client that handles getting, posting, and parsing API responses
  #
  module APIClient
    def get(endpoint)
      uri = URI(location + endpoint)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end

    def post(endpoint, options = {})
      uri = URI(location + endpoint)
      response = Net::HTTP.post_form(uri, options)
      JSON.parse(response.body)
    end

    include Query
    include Control
    include Settings

    @api_ref = JSON.parse(File.read(File.join(__dir__, './api_client/api.json')))

    def self.key_to_description(type, key)
      @api_ref.dig(type, key, 'description') || key
    end

    def self.value_to_formatted(type, key, value)
      case @api_ref.dig(type, key, 'values')
      when 'raw'
        value
      when 'epoch'
        Time.at(value)
      else
        @api_ref.dig(type, key, 'values', value.to_s) || value
      end
    end
  end
end
