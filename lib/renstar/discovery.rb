# frozen_string_literal: true

require 'ssdp'
require 'socket'

module Renstar
  # Helper module for handling SSDP and IP details for discovery thermostats on
  # the network
  module Discovery
    # Discovery timeout when searching for thermostats
    SERVICE = 'venstar:thermostat:ecp'

    private

    def ips
      Socket.ip_address_list.select do |ip|
        ip.ipv4? && !ip.ipv4_loopback?
      end
    end

    # do an SSDP search using the given IP from a found local interface
    def ssdp_search(ip, timeout = 5)
      puts "Searching subnet associated with #{ip.ip_address}"
      ssdp = SSDP::Consumer.new({ bind: ip.ip_address })
      ssdp.search(service: SERVICE, timeout: timeout)
    end
  end
end
