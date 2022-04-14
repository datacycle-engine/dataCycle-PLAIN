# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] ||= 'test'

unless (ENV['TEST_COVERAGE'] || '1').to_i.zero?
  require 'simplecov'
  SimpleCov.start 'rails' do
    # exclude cache folder for gitlab-ci
    add_filter '/cache/'
    add_filter 'vendor'
  end
  SimpleCov.at_exit do
    puts "\n"

    SimpleCov.result.format!

    puts "\nCOVERAGE: " \
         "#{(100 * SimpleCov.result.covered_lines.to_f / SimpleCov.result.total_lines.to_f).round(2)}% " \
         "(#{SimpleCov.result.covered_lines} / #{SimpleCov.result.total_lines} LOC)"
  end
end

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

require File.expand_path('../config/environment.rb', __dir__)

ActiveRecord::Migrator.migrations_paths << File.expand_path('../vendor/gems/data-cycle-core/db/migrate', __dir__)

require 'rails/test_help'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

require 'gems/data-cycle-core/test/helpers/test_preparations_helper'
require 'gems/data-cycle-core/test/helpers/dummy_data_helper'
require 'gems/data-cycle-core/test/helpers/data_helper'
require 'gems/data-cycle-core/test/helpers/mongo_helper'

module DataCycleBase
  module TestPreparations
  end
end

if DataCycleCore::TestPreparations.cli_options.dig(:ignore_preparations)
  Rails.backtrace_cleaner.remove_silencers!
else
  DataCycleCore::TestPreparations.load_classifications(nil)
  DataCycleCore::TestPreparations.load_external_systems(
    [
      DataCycleCore.external_sources_path,
      DataCycleCore.external_systems_path
    ]
  )
  DataCycleCore::TestPreparations.load_templates(
    DataCycleCore.default_template_paths + [DataCycleCore.template_path]
  )
end

# DataCycleCore::TestPreparations.load_dummy_data(
#   [
#     Rails.root.join('vendor', 'gems', 'data-cycle-core', 'test', 'dummy_data'),
#     Rails.root.join('test', 'dummy_data')
#   ]
# )

DataCycleCore::TestPreparations.load_user_roles
DataCycleCore::TestPreparations.create_users
DataCycleCore::TestPreparations.create_user_group
