# frozen_string_literal: true

require 'json'
require 'net/http'

require_relative 'api_client/query'
require_relative 'api_client/control'
require_relative 'api_client/settings'

require_relative 'api_client/api_object'

module Renstar
  # The actual client that handles getting, posting, and parsing API responses
  #
  module APIClient
    class APIError < StandardError; end
    class APIUnknownResponseError < StandardError; end
    def get(endpoint)
      uri = URI(location + endpoint)
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body)
    end

    def post(endpoint, options = {})
      uri = URI(location + endpoint)
      response = Net::HTTP.post_form(uri, options)
      json = JSON.parse(response.body)
      if json['error']
        raise APIError.new(json['reason'])
      elsif json['success']
        json
      else
        raise APIUnknownResponseError.new(response.body)
      end
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
