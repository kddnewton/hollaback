# Hollaback

[![Build Status](https://github.com/kddnewton/hollaback/workflows/Main/badge.svg)](https://github.com/kddnewton/hollaback/actions)
[![Gem Version](https://img.shields.io/gem/v/hollaback.svg)](https://rubygems.org/gems/hollaback)

Builds method chains such that you can execute functions inside of a predefined set of callbacks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hollaback'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hollaback

## Usage

Sometimes you want to execute code in the context of hooks. With this gem you can build `before`, `after`, and `around` callbacks that are executed in the context of the given object. For `before`s and `after`s you can use either symbols or procs. For `around`s you can use symbols.

First, create a `Hollaback::Chain` object that will represent all of the callbacks that will be called around a block of code.

```ruby
require 'hollaback'
chain = Hollaback::Chain.new
```

Then, specify the callbacks that will be called.

```ruby
chain.before :say_hello
chain.before { puts 'How are you?' }
chain.after :say_goodbye
chain.around :say
```

Then, provide a block of code around which the callbacks will be called.

```ruby
compiled = chain.compile { '- Hollaback' }
```

Finally, call the compiled sequence of callbacks (with or without an optional context object on which the symbol callbacks should be defined).

```ruby
class Callbacker
  def say_hello
    puts 'Hello!'
  end

  def say_goodbye
    puts 'Goodbye!'
  end

  def say(&block)
    puts 'speaking... '
    puts yield
    puts '...done.'
  end
end

compiled.call(Callbacker.new)
```

In the above example, the following will output to stdout:

```
speaking... 
Hello!
How are you?
Goodbye!
- Hollaback
...done.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kddnewton/hollaback.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
