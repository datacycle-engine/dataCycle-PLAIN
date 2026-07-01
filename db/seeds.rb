# frozen_string_literal: true

require_relative '../vendor/gems/data-cycle-core/db/seeds'

unless DataCycleCore::User.find_by(email: 'admin@home.com')
  password = SecureRandom.alphanumeric

  DataCycleCore::User.create!(
    {
      email: 'admin@home.com',
      given_name: 'Ad',
      family_name: 'Ministrator',
      external: false,
      password: password,
      confirmed_at: 1.day.ago,
      default_locale: I18n.default_locale,
      ui_locale: I18n.default_locale,
      role_id: DataCycleCore::Role.find_by(name: 'super_admin')&.id
    }
  )

  5.times { puts }
  puts "Superadmin with admin@home.com and #{password} ready to use!"
  5.times { puts }
end
