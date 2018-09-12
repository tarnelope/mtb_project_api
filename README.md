# MTB Project Api Wrapper Gem

A simple wrapper gem to access the [endpoints provided by the public MTB Project API](https://www.mtbproject.com/data).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mtb_project_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mtb_project_api

## Usage

To initialize a `MtbProjectApi::Client`, you'll need your MTB Project login **email** and **private key** which you can find [in the right column here](https://www.mtbproject.com/data).

```
require 'mtb_project_api'

mtb_project_client = MtbProjectApi::Client.new(email, mtb_project_key)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tarnelope/mtb_project_api.
