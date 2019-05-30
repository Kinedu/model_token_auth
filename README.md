# ModelTokenAuth

Plugin RoR that generates tokens in models and authentication in the controllers.

[![Build Status](https://travis-ci.org/Kinedu/model_token_auth.svg?branch=develop)](https://travis-ci.org/Kinedu/model_token_auth) [![Coverage Status](https://coveralls.io/repos/github/armando1339/model_token_auth/badge.svg?branch=develop)](https://coveralls.io/github/armando1339/model_token_auth?branch=develop)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_token_auth'
```

Then execute:

```bash
$ bundle
```

In the root directory:

```bash
$ rails generate access_token
```

Last command will generate a migration, then:

```bash
$ rake db:migrate
```

Once the migration finishes, the models will be ready to be authenticated.

## Usage

This plugin handles Token authentication for models. In models in which
`#acts_as_model_authenticable` method is called, the instances will be able generating
a token by calling the methods `#save`, `#create` and `#create!`of `ActiveRecord::Base`.
The token is generated in an associated model called `AccessToken`.

The plugin also handles authentication in the controllers by inserting a generic
`#authenticate!` calling the method `acts_as_controller_authenticable` in
ApplicationController. This method will verify the existence of the token and
creates the `current_*` method.

To authenticate some token the request will need the standard header `Authorization`
with a token as a value.

### Models

Make models authenticatables.

```ruby
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

Allow controllers to handle token authentication.

```ruby
class ApplicationController < ActionController::Base
  acts_as_controller_authenticable
end

# for API only

class ApplicationController < ActionController::API
  acts_as_controller_authenticable
end
```

Then.

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

## Rspec

To facilitate the testing of the controllers:

1.- Add a new folder with the name of `support` in the root of `spec`.

2.- Create a ruby file with the name of model_token_auth_helper (`model_token_auth_helper.rb`).

3.- Copy the following code:

```ruby
# model_token_auth_helper.rb

module ModelTokenAuthHelper

  # => skip authentication but still creates the
  # instance variable #current_<model-name>.
  #
  def skip_authentication!(access_token)
    subject.class.skip_before_action(:authenticate!, raise: false)
    subject.send(:authenticate_entity, access_token)
  end

  # => add the 'Authorization' header with the
  # value of the token that is passed to it,
  # giving it the necessary format.
  #
  def add_authorization_header(access_token)
    subject.request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Token.encode_credentials(access_token.token)
  end
end
```

4.- Require `ModelTokenAuthHelper` at the top of the file `spec_helper.rb` and add the module to the RSpec configuration:

```ruby
# spec_helper.rb

require_relative 'support/model_token_auth_helper'

RSpec.configure do |config|
  ...

  # => *
  config.include ModelTokenAuthHelper, type: :controller
end
```

### ModelTokenAuthHelper Usage

Here is described how to use the methods of the ModelTokenAuthHelper module that we created.

```ruby
require 'rails_helper'

RSpec.describe DummiesController do
  describe 'controllers authentication' do

    # => EXAMPLE 1
    context '#authenticate!' do
      before do

        # You can use this method to add the
        # necessary header and allow the control
        # to do its magic
        #
        add_authorization_header(dummy.access_token.token)

        get :index, format: :json
      end

      it { expect(response).to be_successful }

      it { expect(subject.respond_to? :current_center).to be_truthy }
    end

    # => EXAMPLE 2
    context 'skip #authenticate!' do
      before do
        # You can use this method to skip
        # the #authenticate! method but still
        # have access to the current_* variable
        #
        skip_authentication!(dummy.access_token)

        get :index, format: :json
      end

      it { expect(response).to be_successful }

      it { expect(subject.respond_to? :current_center).to be_truthy }
    end
  end
end
```

## Contributing

Bug report or pull request are welcome.

Make a pull request:

- Clone the repo
- Create your feature branch
- Commit your changes
- Push the branch
- Create new Pull-Request

Please write tests if necessary.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
