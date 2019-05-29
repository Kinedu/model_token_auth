$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "model_token_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "model_token_auth"
  spec.version     = ModelTokenAuth::VERSION
  spec.author      = "Armando Alejandre"
  spec.email       = ["armando1339@gmail.com"]
  spec.homepage    = "https://www.kinedu.com/"
  spec.metadata    = { "source_code_uri" => "https://github.com/Kinedu/model_token_auth" }
  spec.summary     = "Plugin RoR that generates tokens in models and authentication in the controllers."
  spec.description = "Plugin RoR that generates tokens in models and authentication in the controllers."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.2"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "shoulda-callback-matchers"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
end
