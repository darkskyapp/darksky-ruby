# darksky

Ruby gem for retrieving data from the [Dark Sky API](http://darkskyapp.com/api/). The Dark Sky API lets you query 
for short-term precipitation forecast data at geographical points inside the United States. 

## Installation

`gem install darksky`

or in your `Gemfile`

```ruby
gem 'darksky'
```
  
## Usage

```ruby
darksky = Darksky::API.new('d41d8cd98f00b204e9800998ecf8427e')
forecast = darksky.forecast('42.7243','-73.6927')
precipitation = darksky.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])
```

## Contributing to darksky
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 David Czarnecki. See LICENSE.txt for further details.
