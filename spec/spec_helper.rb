# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

begin
  require "simplecov"

  SimpleCov.start "rails" do
    add_filter %w[lib/hotsheet/version.rb]
    enable_coverage :branch
    minimum_coverage line: 50, branch: 100
  end
rescue LoadError
  nil
end

require_relative "dummy/config/environment"
require_relative "support/utils"
require "rspec/rails"
require "selenium-webdriver"

%i[firefox firefox_headless].each do |driver|
  Capybara.register_driver driver do |app|
    args = ["--headless"] if driver == :firefox_headless
    options = Selenium::WebDriver::Firefox::Options.new args: args
    Capybara::Selenium::Driver.new app, browser: :firefox, options: options
  end
end

driver = ENV.fetch("SELENIUM_DRIVER", "firefox_headless").to_sym
Capybara.default_driver = :rack_test
Capybara.javascript_driver = driver

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  Kernel.srand config.seed

  config.include Capybara::DSL, type: :system

  config.disable_monkey_patching!
  config.filter_rails_from_backtrace!
  config.fixture_paths = ["spec/fixtures"]
  config.infer_spec_type_from_file_location!
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = true

  config.before :all, type: :system do
    driven_by driver, screen_size: [1280, 800]
  end
end
