# frozen_string_literal: true

require 'renstar'
require 'optparse'
require 'ostruct'

options = {}

# DEFAULT_OPTIONS = { all: false }.freeze

USAGE = ' Usage: renstar.rb command [value]

    Informational Commands:
      info     - Show current settings
      sensors  - Show current Sensor reading
      runtimes - Show last 7 days of usage times
      alerts   - Show alerts and their statuses

    Control Commands:
     Note: Temp values are integers. Device settings determine units.
      heat $TEMP             - Heat to $TEMP
      cool $TEMP             - Cool to $TEMP
      auto $LO_TEMP $HI_TEMP - Keep temp in between two temps
      off                    - Turn off heating and/or cooling
      fan_on                 - Turn on the fan
      fan_off                - Turn on the fan
      fan_toggle             - Toggle the fan on/off
      schedule_on            - Turn on the schedule
      schedule_off           - Turn off the schedule
      schedule_toggle        - Toggle the schedule on/off
      home                   - Set "Home"
      away                   - Set "Away"

'

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
command = if ARGV.nil? || ARGV.empty?
            'info'
          else
            ARGV
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
