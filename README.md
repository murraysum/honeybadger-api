# Honeybadger Read Api Ruby Library

This is the Read API gem for easily pulling your data out of [Honeybadger](https://www.honeybadger.io/).

## Installation

Add this line to your application's Gemfile:

    gem 'honeybadger-read-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install honeybadger-read-api

## Usage

Firstly require the library:

```
require 'honeybadger-read-api'
```

Then configure your personal API access token. Your personal API access token can be found on your [personal profile page](https://www.honeybadger.io/users/edit):

```
Honeybadger::Read.configure do |c|
  c.access_token = 'xxxxxxxxxxxxxxxxxxxx'
end
```

After you have setup your API access token you can now make requests:

```
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
