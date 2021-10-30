# frozen_string_literal: true

require 'ssdp'
require_relative 'api_client'

module Renstar
  # Thermostat object
  # Contains convenience methods along the lines of what is provided in the
  # mobile app, website, or control panel, e.g. Heat, Cool, Auto, Fan, Schedule
  # Home/Away, and Off
  #
  class Thermostat
    SERVICE = 'venstar:thermostat:ecp'
    DEFAULT_TIMEOUT = 5

    attr_reader :location, :usn, :cached_info

    include APIClient

    def initialize(location, usn)
      @location = location
      @usn = usn
      @cache_timestamp = Time.now
      @cached_info = info
    end

    def self.search(timeout = DEFAULT_TIMEOUT)
      ssdp = SSDP::Consumer.new
      thermos = ssdp.search(service: SERVICE, timeout: timeout)
      thermos.map do |thermo|
        location = thermo[:params]['Location']
        usn = thermo[:params]['USN']
        Renstar::Thermostat.new(location, usn)
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
      update
      if heattemp
        cooltemp = heattemp + 1.0
      else
        cooltemp = @cached_info.cooltemp
        heattemp = @cached_info.heattemp
      end
      response = control("mode": 1, "cooltemp": cooltemp, "heattemp": heattemp)
      update
      response
    end

    def cool(cooltemp = nil)
      update
      if cooltemp
        heattemp = cooltemp - 1.0
        # heattemp = cooltemp - @cached_info.setpointdelta
      else
        cooltemp = @cached_info.cooltemp
        heattemp = @cached_info.heattemp
      end
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
      if @cached_info.fan == 1
        fan_off
      else
        fan_on
      end
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
      if @cached_info.schedule == 1
        schedule_off
      else
        schedule_on
      end
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
  end
end
