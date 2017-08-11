# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'mongoid-rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
DatabaseCleaner[:mongoid].strategy = :truncation

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods
  config.include Mongoid::Matchers, type: :model

  config.before(:suite) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end
