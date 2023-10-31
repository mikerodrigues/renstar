# frozen_string_literal: true

require 'ssdp'
require 'socket'

module Renstar
  module Discovery
    # Discovery timeout when searching for thermostats
    DEFAULT_TIMEOUT = 3
    SERVICE = 'venstar:thermostat:ecp'

    def self.search(timeout = DEFAULT_TIMEOUT)
      all_thermos = []
      ips.each do |ip|
        puts "Searching subnet associated with #{ip.ip_address}"
        ssdp = SSDP::Consumer.new({ bind: ip.ip_address })
        thermos = ssdp.search(service: SERVICE, timeout: timeout)
        thermos.each do |thermo|
          location = thermo[:params]['Location']
          usn = thermo[:params]['USN']
          all_thermos << Renstar::Thermostat.new(location, usn)
        end
      end
      all_thermos
    end

    private

    def ips
      ips = Socket.ip_address_list.select do |ip|
        ip.ipv4? && !ip.ipv4_loopback?
      end
    end

  end
end
