require 'simplecov'
SimpleCov.start do
  add_group("Controllers", "app/controllers/")
  add_group("Domain", "app/domain/")
  add_group("Persistence", "app/models/")
  add_group("Services", "app/services/")
  add_group("Page object usage", "spec/helpers/pages")
  add_group("Page object sections usage", "spec/helpers/page_sections")
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/helpers/**/*.rb")].each { |file| require file }
Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each { |file| require file }
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require "capybara/cuprite"
require 'capybara-screenshot/rspec'
require 'database_cleaner'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.always_include_port = true
Capybara.run_server = true
Capybara.app_host = "http://127.0.0.1:3030"
Capybara.default_host = Capybara.app_host
Capybara.server = :puma, { Silent: true }
Capybara.server_host = '127.0.0.1'
Capybara.server_port = 3030
Capybara.default_max_wait_time = 5
Capybara.javascript_driver = :cuprite
Capybara.save_path = "tmp/screenshots/"

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, {
    window_size: [1680, 1050],
    url_whitelist: ["http://127.0.0.1:3030"]
    })
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.default_formatter = "doc"
  config.profile_examples = 10
  config.order = :random

  config.include FactoryBot::Syntax::Methods
  config.include TournamentsHelper
  config.include ImportHelper
  config.include GeneralFeatureSpecsMethods, type: :feature

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:each) do |example|
    Faker::UniqueGenerator.clear
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
