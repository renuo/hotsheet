# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "rspec/rails"
require_relative "config/environment"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  Kernel.srand config.seed

  config.disable_monkey_patching!
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.order = :random
  config.run_all_when_everything_filtered = true
end
