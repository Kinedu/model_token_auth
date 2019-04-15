# ModelTokenAuth

Generates tokens in models and authentication in the controllers.

#### Status

[![Build Status](https://travis-ci.org/armando1339/model_token_auth.svg?branch=develop)](https://travis-ci.org/armando1339/model_token_auth)

## Usage

This plugin handles Token API authentication for models. In the model in which
`#acts_as_model_authenticable` method is called, the instances will be able generating
a token by calling the methods `#save`, `#create` and `#create!`of ActiveRecord.

```ruby
# create new record
center = Center.create!

# verify token existence
center.access_token

# => #<AccessToken:0x00007fca2b1ff430
#  id: 31,
#  token: "e897f48950a5c946cd22c4d0c41ad3d3",
#  entity_type: "Center",
#  entity_id: 26,
#  created_at: Fri, 12 Apr 2019 16:42:52 UTC +00:00,
#  updated_at: Fri, 12 Apr 2019 16:42:52 UTC +00:00>
```

The plugin also handles authentication in the controllers by inserting a generic
`#authenticate!` method that will verify the existence of the token and creates
the `current_*` method. Just add a header in the request with the value `X-Auth-Token`
and then in controllers:

```ruby
# open a scope for centers

module Centers
  class DummiesController < ApplicationController
    before_action :authenticate!

    # using current_* generated
    def show
      @current = current_center
    end

    # another example
    def index
      @dummies = current_center.dummies
    end

    ...
  end
end
```


### Models

Make models authenticatables.

```ruby
# example

class Center < ActiveRecord::Base
  acts_as_model_authenticable
end
```

### Controllers

Allow controllers to handle token authentication

```ruby
# example ActionController::Base

class ApplicationController < ActionController::Base
  acts_as_controller_authenticable
end

# for API only

class ApplicationController < ActionController::API
  acts_as_controller_authenticable
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_token_auth'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install model_token_auth
```

## Contributing

Bug report or pull request are welcome.

Make a pull request:

- Fork it
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin HEAD)
- Create new Pull Request

Please write tests if necessary.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
