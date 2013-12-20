# Honeybadger::Read::Api

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'honeybadger-read-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install honeybadger-read-api

## Usage

```
require 'honeybadger-read-api'

# Configure you access token
Honeybadger::Read.configure do |c|
  c.access_token = 'xxxxxxxxxxxxxxxxxxxx'
end

# Find a project
project_id = 1
Honeybadger::Read::Project.find(project_id)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
