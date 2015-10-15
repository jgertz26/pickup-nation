ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda-matchers'
require File.join(File.dirname(__FILE__), 'support/valid_attribute')
require File.join(File.dirname(__FILE__), 'support/factory_girl')
require File.join(File.dirname(__FILE__), 'support/geocoder')
require File.join(File.dirname(__FILE__), 'support/helpers')
require File.join(File.dirname(__FILE__), 'support/database_cleaner')
require 'capybara/rspec'
Capybara.javascript_driver = :selenium

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Helpers
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end
