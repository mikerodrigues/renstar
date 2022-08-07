# Renstar

Renstar is a Ruby SDK for interacting with the Venstar Thermostat Local API.

You can control your thermostat programmatically!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'renstar'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install renstar

## Using the included binary

When installing the gem, we install `renstar.rb` for you automatically. You can
pass the `-h` flag for more info.

The help page does not list all the accepted commands or their values but all of
the methods below are supported. The binary just passes your arguments to the
methods below.

So, if you want to cool your house to 72 using the binary, you can do this:
```ruby
renstar.rb cool 72
```

You can apply the logic above to any of the methods below for the same effect.

### Note about thermostat selection
The binary chooses the first thermostat it finds on the network, so you may get
unexpected results if you have more than one on your network. I do plan on
improving this.

## Using the library

First we need to create a `Thermostat` object.

* Search for thermostats on the LAN, return the first one found:
```ruby
thermo = Renstar::Thermostat.search.first
```

### Query

These methods let you see the thermostat info (controls and settings status), sensor info, runtimes, and
alerts.

* Get information about the thermostat:
```ruby
thermo.info
```

* Get the current sensors and their readings:
```ruby
thermo.sensors
```

* Get runtimes:
```ruby
thermo.runtimes
```

* See alerts and their status:
```ruby
thermo.alerts
```

### Control

These methods let you control the thermostat temperature controls, and fan. You
can use the `info` method to check the current state of these controls.

* Heat to 80 degrees:
```ruby
thermo.heat(80)
```

* Cool to 60 degrees:
```ruby
thermo.cool(60)
```

* Automatically keep the temp between 70 and 74 degrees:
```ruby
thermo.auto(70, 74)
```

* Turn off heating and/or cooling
```ruby
thermo.off
```

* Control the fan:
```ruby
thermo.fan_on

thermo.fan_off

thermo.fan_toggle
```

### Settings

These methods let you change the schedule and vacation settings on your
thermostat. You can use the `info` method to check the current state of the
settings.

* Set the schedule:
```ruby
thermo.schedule_on

thermo.schedule_off

thermo.schedule_toggle
```

* Set Home/Away:
```ruby
thermo.home

thermo.away
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/renstar.
