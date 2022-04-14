# frozen_string_literal: true

DataCycleCore.setup do |config|
  I18n.available_locales = %i[de en]
  # Configure sensitive parameters which will be filtered from the log file.
  Rails.application.config.filter_parameters += %i[password]
  Rails.application.config.session_store :cookie_store, key: '_datacycle-plain_session', same_site: :lax

  config.template_path = Rails.root.join('config', 'data_definitions').freeze

  config.default_template_paths = [
    Datacycle::Schema::Common.templates
  ].freeze

  config.external_sources_path = [].freeze
end
