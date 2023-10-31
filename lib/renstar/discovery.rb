# frozen_string_literal: true

require 'ssdp'
require 'socket'

module Renstar
  # Helper module for handling SSDP and IP details for discovery thermostats on
  # the network
  module Discovery
    # Discovery timeout when searching for thermostats
    DEFAULT_TIMEOUT = 3
    SERVICE = 'venstar:thermostat:ecp'

    def search(timeout = DEFAULT_TIMEOUT)
      all_thermos = []
      ips.each do |ip|
        all_thermos << ssdp_search(ip, timeout)
      end
      all_thermos.flatten
    end

    private

    def ips
      Socket.ip_address_list.select do |ip|
        ip.ipv4? && !ip.ipv4_loopback?
      end
    end

    # do an SSDP search using the given IP from a found local interface
    def ssdp_search(ip, timeout = DEFAULT_TIMEOUT)
      puts "Searching subnet associated with #{ip.ip_address}"
      ssdp = SSDP::Consumer.new({ bind: ip.ip_address })
      thermos = ssdp.search(service: SERVICE, timeout: timeout)
      thermos.map do |thermo|
        location = thermo[:params]['Location']
        usn = thermo[:params]['USN']
        Renstar::Thermostat.new(location, usn)
      end
    end
  end
end
