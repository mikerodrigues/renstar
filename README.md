# Renstar

Renstar is a Ruby SDK for interacting with the Venstar API.

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

## Usage

* Search for thermostats on the LAN, return the first one found:
```ruby
thermo = Renstar::Thermostat.search.first
```

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

* Turn off heeating and/or cooling
```ruby
thermo.off
```

* Control the fan:
```ruby
thermo.fan_on

thermo.fan_off

thermo.fan_toggle
```

* Control the schedule:
```ruby
thermo.schedule_on

thermo.scheduel_off

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
