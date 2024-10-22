# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path "../Gemfile", __dir__

require "bundler/setup"
require "rails/all"

Bundler.require(*Rails.groups)

module Lw2024DemoProject
  class Application < Rails::Application
    config.load_defaults 8.1
  end
end
