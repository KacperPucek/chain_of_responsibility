# chain_of_responsibility

[![CircleCI](https://circleci.com/gh/KacperPucek/chain_of_responsibility.svg?style=shield)](https://circleci.com/gh/KacperPucek/chain_of_responsibility)
[![Maintainability](https://api.codeclimate.com/v1/badges/b9b001acc0dfd25d0c19/maintainability)](https://codeclimate.com/github/KacperPucek/chain_of_responsibility/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b9b001acc0dfd25d0c19/test_coverage)](https://codeclimate.com/github/KacperPucek/chain_of_responsibility/test_coverage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "chain_of_responsibility"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chain_of_responsibility

## About

Some time ago I've stumbled upon pretty nice [article](http://rubyblog.pro/2017/11/chain-of-responsibility-ruby) written by *Sergii Makagon* about a chain of
responsibility pattern which I highly encourage you to read.

The main idea is that we can change nasty `if/else` statements to a chain of
handlers that can decide whether they are applicable or not. Handlers
are specified in the certain order and when we get a match we resolve using an appropriate handler.

This `gem` provides a tiny wrapper to make defining `chains` nicer. It's pretty minimal so feel free to simply copy the source code and adjust it to your needs if you wish.

## Usage

A chain is composed of handlers defined in a specific order which are called one by one until
there's a handler that can handle the request. If none of the handlers can be used, error will
be raised.

### Handlers

Handlers should inherit from `ChainOfResponsibility::Handler` and define `applicable?` and `resolve` methods that can take an arbitrary number of arguments (but both the same).

Example:

```ruby
module Handlers
  class WelcomeEmailHandler < ChainOfResponsibility::Handler
    def applicable?(user)
      user.registered? && user.confirmed?
    end

    def resolve(user)
      # send email
    end
  end
end
```

### Chain

Once you have your specific handlers defined, you can easily compose them.

Example

```ruby
module Handlers
  class Passing < ChainOfResponsibility::Handler
    def applicable?
      true
    end

    def resolve
      :ok
    end
  end
end

module Handlers
  class Failing < ChainOfResponsibility::Handler
    def applicable?
      false
    end

    def resolve
      # won't be reached
    end
  end
end

class PassingTransaction
  include ChainOfResponsibility

  def_handler Handlers::Failing
  def_handler Handlers::Passing

  def call
    chain.call
  end
end

PassingTransaction.new.call # => :ok

class FailingTransation
  include ChainOfResponsibility

  def_handler Handlers::Failing

  def call
    chain.call
  end
end

FailingTransation.new.call # => ChainOfResponsibility::NoAppropriateHandlerFoundError
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KacperPucek/chain_of_responsibility. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

