require 'renstar'
require 'optparse'
require 'ostruct'

class RenstarOptions
  DEFAULT_OPTIONS = { all: false }.freeze
  USAGE = " Usage: renstar.rb command [value]"

  def self.parse(args)

    @options = OpenStruct.new(DEFAULT_OPTIONS)

    options = OptionParser.new do |opts|
      opts.banner = USAGE

      opts.on '-d', '--discover', 'Discover all Renstar devices' do |d|
        @options.discover = true
      end

      opts.on '-h', '--help', 'Display this screen' do |h|
        @options.help = true
      end
    end

    options.parse!(args)

    puts options if @options && ARGV == []

    if @options.discover
      Renstar.discover.each do |device|
        puts "#{device.name} #{device.ip}"
      end
      exit 0
    end

    if @options.help
      puts opts
      exit 0
    end


  end
end

@options = RenstarOptions.parse(ARGV)

thermo = Renstar::Thermostat.search.first


thermo.send(*ARGV)