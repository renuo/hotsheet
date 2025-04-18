# frozen_string_literal: true

require "bundler/setup"
require "logger"
require "action_controller/railtie"
require "active_record/railtie"
require "propshaft"
require "rails"

Bundler.require(*Rails.groups)

class Dummy < Rails::Application
  config.load_defaults Rails::VERSION::STRING.to_f
end
