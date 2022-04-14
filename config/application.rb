# frozen_string_literal: true

require_relative 'boot'

require_relative '../vendor/gems/data-cycle-core/test/dummy/lib/require_rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataCycleBase
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('vendor', 'gems', 'datacycle-*', 'lib')]
    config.eager_load_paths += Dir[Rails.root.join('vendor', 'gems', 'datacycle-*', 'lib')]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
