class AccessTokenGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('templates', __dir__)

  def migration
    migration_template(
      'migration.rb',
      'db/migrate/create_access_tokens.rb'
    )
  end

  def rails5_and_up?
    Rails::VERSION::MAJOR >= 5
  end

  def migration_version
    if rails5_and_up?
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end
  end

  def self.next_migration_number(dir)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end
end
