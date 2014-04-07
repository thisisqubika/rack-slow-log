# Rack::SlowLog

Allows for setting the maximum request time before it get logged also provides a custom
log to data relevant to the slow request and can even provide a different log for each slow
request for easy debugging.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-slow-log'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-slow-log

## Usage

To use just add this to you config.ru
```ruby
require 'rack-slow-log'

use Rack::SlowLog
```
or if you are using rails, add this to an initializer:
```ruby
Rails::Application.config.middleware.use Rack::SlowLog
```

## Configuration

You configure rack-slow-log like any other rack middleware:
```ruby
require 'rack-slow-log'

use Rack::SlowLog, { :long_request_time => 5 }
```

### Available options:

- long_request_time: Indicates the maximum request time (in seconds) before it gets logged, it can
  also take fractions of a second. Default: 5
- slow_log: The file used for logging. Default: log/slow.log
- one_log_per_request: Indicates if each slow request is logged to a different file, if set to true
  the slow log files would be #{slow_log}#{timestamp}. Default: false

## Adding additional log:

This middleware adds a new key to the rack env to allow adding more information to the slow log,
example:
```ruby
env['rack.slow_log'].log('Some log line')
env['rack.slow_log'] << 'Other log line'
```
If the request exceeds the allowed time the it will be logged and the logged lines will appear on
the log otherwise they will be discarded.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/rack-slow-log/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request