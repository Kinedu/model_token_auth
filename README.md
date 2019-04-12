# ModelTokenAuth

Model authenticator; Generates a token in the models and authenticates them in the controllers.

#### Status

## Usage

This gem handles Token API authentication for models. Generate a token in the models in which
`acts_as_model_authenticable` method callback is called by calling the methods #save, #create and #create!
of ActiveRecord. It also handles authentication in the controllers by inserting a generic #authenticate!
method that will verify the existence of the token and creates the `current_*` method.

### Models

Make models token authenticatable.

```ruby
# example
class Center < ActiveRecord::Base
  acts_as_model_authenticable
end
```

Then.

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

### Controllers

Allow controllers to handle token authentication

```ruby
# example ActionController::Base

class ApplicationController < ActionController::Base
  acts_as_controller_authenticable
end

# for API only (ActionController::API)

class ApplicationController < ActionController::API
  acts_as_controller_authenticable
end
```

Then in controllers

```ruby
# open a scope for centers
class Centers::DummiesController < ApplicationController
  before_action :authenticate!

  # using current_* generated
  def index
    current_center
  end
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

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
