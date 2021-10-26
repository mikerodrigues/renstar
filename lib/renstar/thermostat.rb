require 'ssdp'
require_relative 'api_client'


module Renstar
  class Thermostat
    SERVICE = "venstar:thermostat:ecp"
    DEFAULT_TIMEOUT = 5
    include APIClient

    attr_reader :location
    attr_reader :usn

    def initialize( location, usn)
      @location = location
      @usn = usn
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
  end
end
