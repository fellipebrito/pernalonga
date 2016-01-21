# Pernalonga [![Code Climate](https://codeclimate.com/github/fellipebrito/pernalonga/badges/gpa.svg)](https://codeclimate.com/github/fellipebrito/pernalonga) [![Test Coverage](https://codeclimate.com/github/fellipebrito/pernalonga/badges/coverage.svg)](https://codeclimate.com/github/fellipebrito/pernalonga/coverage)

Pernalonga is a simple wrapper for the Ruby gem Bunny. While Bunny has all classes and methods for utilizing an AMQP queuing system, the code for doing so can take up a lot of space and tends to be repeated across many projects.

## Usage
Pernalonga sets up the logic of publishing and subscribing to queues and processing messages.

### Connection Configuration
Your connection configurations must be environment variables.

Pernalonga uses [dotenv](https://github.com/bkeepers/dotenv) to autoload any information you have in a .env file.

A sample .env file would contain the following required variables.
```
BUNNY_USER=abc
BUNNY_VHOST=abc
BUNNY_PASSWORD=abc
BUNNY_HOST=abc
```

### Consuming
As long as you’re a basic queue without an exchange, you don’t have to setup all the Bunny objects for Connections, Channels and arrange your message processing logic within them.

Instead, the only required thing is to simply implement a `process_message` method in your class. This way, once you call `Pernalonga.consume self, "queue_name"` to process messages from a queue, Pernalonga will call back your `process_message` method passing the message as the unique parameter.

### Enqueuing
To enqueue messages
 just use `Pernalonga.enqueue "queue_name" message`.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pernalonga'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pernalonga

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fellipebrito/pernalonga.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

