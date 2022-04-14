# frozen_string_literal: true

Warning[:deprecated] = false
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'vendor/gems/data-cycle-core/test'
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
