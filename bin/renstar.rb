# frozen_string_literal: true

require 'renstar'
require 'optparse'
require 'ostruct'

options = {}

# DEFAULT_OPTIONS = { all: false }.freeze

USAGE = ' Usage: renstar.rb command [value]'

Options = Struct.new(:thermostat)
args = Options.new

OptionParser.new do |opts|
  opts.banner = USAGE

  opts.on '-d', '--discover', 'Discover all Renstar devices' do |_d|
    options[:discover] = true
  end

  opts.on '-h', '--help', 'Display this screen' do |_h|
    puts opts
    exit 0
  end

  opts.on '-tTHERMOSTAT', '--thermostat=THERMOSTAT', 'Use thermostat by host name or IP. No discovery.' do |t|
    args.thermostat = t
  end
end.parse!

if options[:discover]
  thermos = Renstar::Thermostat.search
  thermos.each do |t|
    puts "Found: #{t.location} #{t.usn}"
  end
  exit 0
end

thermo = nil
if args.thermostat
  thermo = Renstar::Thermostat.new(args.thermostat)
  puts "Using: #{thermo.location}"
else
  thermos = Renstar::Thermostat.search
  thermos.each do |t|
    puts "Found: #{t.location} #{t.usn}"
  end
  thermo = thermos.first
  puts "Using: #{thermo.location} - #{thermo.usn}"
end
command = nil
if ARGV.nil? || ARGV.empty?
  command = 'info'
else
  command = ARGV
end

response = thermo.send(*command)
case response
when String
  puts response
when Renstar::APIClient::APIObject
  response.pp
when Array
  response.each(&:pp)
end
