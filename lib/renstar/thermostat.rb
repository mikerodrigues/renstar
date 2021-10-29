require 'ssdp'
require_relative 'api_client'

module Renstar
  class Thermostat
    SERVICE = "venstar:thermostat:ecp"
    DEFAULT_TIMEOUT = 5

    attr_reader :location
    attr_reader :usn
    attr_reader :info

    include APIClient

    def initialize(location, usn)
      @location = location
      @usn = usn
      @cached_info = self.info
    end

    def self.search()
      ssdp = SSDP::Consumer.new
      thermos = ssdp.search( :service => SERVICE, :timeout => DEFAULT_TIMEOUT )
      thermos.map do | thermo |
        location = thermo[:params]['Location']
        usn = thermo[:params]['USN']
        Renstar::Thermostat.new(location, usn)
      end
    end

    def cool(cooltemp = nil)
      if cooltemp
        heattemp = cooltemp - 1.0
        # heattemp = cooltemp - @cached_info.setpointdelta
      else
        cooltemp = @cached_info.cooltemp
        heattemp = @cached_info.heattemp
      end
      mode =  2
      control("mode": mode, "cooltemp": cooltemp, "heattemp": heattemp)
    end
  end
end
