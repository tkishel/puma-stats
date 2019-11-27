# puma-stats

A puma plugin to expose Puma's internal statistics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puma-stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puma-stats

## Usage

Add following lines to your puma `config.rb` (see
[Configuration File](https://github.com/puma/puma#configuration-file)):

```ruby
# config/puma.rb

plugin 'stats'

# Bind the stats server to "url". "tcp://" is the only accepted protocol.
#
# stats_url 'tcp://0.0.0.0:12345'
# stats_token 'knockknock'
```

## Credits

The gem is inspired by the following projects:
* https://github.com/puma/puma-metrics

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

