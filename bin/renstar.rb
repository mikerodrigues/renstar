require 'renstar'
require 'optparse'
require 'ostruct'

options = {}

#DEFAULT_OPTIONS = { all: false }.freeze


USAGE = " Usage: renstar.rb command [value]"

OptionParser.new do |opts|

  opts.banner = USAGE

  opts.on '-d', '--discover', 'Discover all Renstar devices' do |d|
    options[:discover] = true
  end

  opts.on '-h', '--help', 'Display this screen' do |h|
    puts opts
    exit 0
  end
end.parse!

if options[:discover]
  thermos = Renstar::Thermostat.search
  thermos.each do |thermo|
    puts "Found: #{thermo.location} #{thermo.usn}"
  end
  exit 0
end


thermos = Renstar::Thermostat.search
thermos.each do |thermo|
  puts "Found: #{thermo.location} #{thermo.usn}"
end
puts "Using: " + thermos.first.location + " - " + thermos.first.usn
unless (ARGV.nil? || ARGV.empty?)
  puts thermos.first.send(*ARGV)
end
