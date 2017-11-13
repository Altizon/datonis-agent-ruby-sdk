Datonis Edge SDK Ruby
==========================

Ruby version of Datonis Edge SDK.
Gem that allows to communicate and send endpoint data to the Datonis Platform.

## Installing gem globally in your system
Go inside edge directory.

Build the gem:

	  gem build edge.gemspec
	
Install the builded gem:

	  gem install edge-3.0.2.gem 


## Installation for ruby applications
Add this line to your application's Gemfile:

```ruby
gem 'edge'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edge

## Usage
Go inside example directory.
Modify the sample.py file as follows:

1. Add appropriate access_key and secret_key from the downloded key_pair in `Edge::EdgeConfiguration` method.
2. Add Thing key, Thing name, Thing Description of the thing whose data you want to send to Datonis. Add these info inside `Edge::Thing` method.
3. Finally add the metrics name and its value inside `data` hash. You can also set waypoints and send it to Datonis

Example:
```ruby
ruby sample.rb
```
