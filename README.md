# MTB Project Api Wrapper Gem

A simple wrapper gem to access the [public endpoints provided by the  MTB Project API](https://www.mtbproject.com/data).

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
Here are the following calls you can make:

**.get_local_trails**
```
# Returns trails for a given query.
#
# Required Arguments:
# lat - Latitude for a given area
# lon - Longitude for a given area
#
# Optional Arguments:
# maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200.
# maxResults - Max number of trails to return. Default: 10. Max: 500.
# sort - Values can be 'quality', 'distance'. Default: quality.
# minLength - Min trail length, in miles. Default: 0 (no minimum).
# minStars - Min star rating, 0-4. Default: 0.

params = {
  lat: 40.0274,
  lon: -105.2519,
  maxDistance: 10
}

mtb_project_client.get_local_trails(params)
```

**.get_trails_by_id**
```
# Returns trails for given trail IDs.
#
# Required Arguments:
# ids - one or array of trail IDs

params = {
  ids: [343243, 5653463, 423426]
}

mtb_project_client.get_trails_by_id(params)
```

**.get_conditions**
```
# Returns conditions for given trail IDs.
#
# Required Arguments:
# ids - one or array of trail IDs

params = {
  ids: [343243, 5653463, 423426]
}

mtb_project_client.get_conditions(params)
```

**.get_to_dos**
```
# Returns up to 200 of the user's to-do trail IDs.
#
# Optional Arguments:
# startPos - The starting index of the list to return. Defaults to 0.

params = {
  startPos: 3
}
mtb_project_client.get_to_dos(params)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tarnelope/mtb_project_api.
