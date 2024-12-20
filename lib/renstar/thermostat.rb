# frozen_string_literal: true

require_relative 'api_client'
require_relative 'discovery'

module Renstar
  # Thermostat object
  # Contains convenience methods along the lines of what is provided in the
  # mobile app, website, or control panel, e.g. Heat, Cool, Auto, Fan, Schedule
  # Home/Away, and Off
  #
  class Thermostat
    USN_REGEX = /^(\w+):(\w+)+:((?:[0-9a-fA-F]{2}:?)+):name:(.*):type:(.*)/

    attr_reader :location, :usn, :cached_info

    include APIClient
    extend Discovery

    def initialize(location, usn = nil)
      if location && usn
        @location = location
        @usn = usn
      else
        @location = "http://#{location}/"
        @usn = ''
      end

      @cache_timestamp = Time.now
      @cached_info = info
    end

    def self.search(timeout = 3)
      all_thermos = ips.each do |ip|
        all_thermos << ssdp_search(ip, timeout)
      end

      all_thermos.flatten.map do |thermo|
        Renstar::Thermostat.new(thermo[:params]['Location'], thermo[:params]['USN'])
      end
    end

    def update
      @cache_timestamp = Time.now
      @cached_info = info
    end

    def off
      response = control("mode": 0, "cooltemp": @cached_info.cooltemp, "heattemp": @cached_info.heattemp)
      update
      response
    end

    def heat(heattemp = nil)
      cooltemp, heattemp = set_temps(heattemp, 1)
      response = control("mode": 1, "cooltemp": cooltemp, "heattemp": heattemp)
      update
      response
    end

    def cool(cooltemp = nil)
      cooltemp, heattemp = set_temps(cooltemp, 2)
      response = control("mode": 2, "cooltemp": cooltemp, "heattemp": heattemp)
      update
      response
    end

    def auto(heattemp = nil, cooltemp = nil)
      # we want to make sure we have the latest values
      # so we'll update then set the defaults
      update
      heattemp ||= @cached_info.heattemp
      cooltemp ||= @cached_info.cooltemp
      response = control("mode": 3, "cooltemp": cooltemp, "heattemp": heattemp)
      update
      response
    end

    def fan_off
      response = control("fan": 0)
      update
      response
    end

    def fan_on
      response = control("fan": 1)
      update
      response
    end

    def fan_toggle
      @cached_info.fan == 1 ? fan_off : fan_on
    end

    def schedule_off
      response = settings("schedule": 0)
      update
      response
    end

    def schedule_on
      response = settings("schedule": 1)
      update
      response
    end

    def schedule_toggle
      @cached_info.schedule == 1 ? schedule_off : schedule_on
    end

    def home
      response = settings("away": 0)
      update
      response
    end

    def away
      response = settings("away": 1)
      update
      response
    end

    private

    def set_temps(temp, mode)
      update
      if temp
        if mode == 1
          cooltemp = temp.to_i + 1
          heattemp = temp.to_i
        else
          cooltemp = temp.to_i
          heattemp = temp.to_i - 1
        end
      else
        cooltemp = @cached_info.cooltemp
        heattemp = @cached_info.heattemp
      end
      [cooltemp, heattemp]
    end
  end
end
