# frozen_string_literal: true

require "bundler/setup"
require "logger"
require "action_controller/railtie"
require "active_record/railtie"
require "active_support/railtie"
require "rails"

Bundler.require(*Rails.groups)

class Dummy < Rails::Application
  config.load_defaults Rails::VERSION::STRING.to_f

  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = :rescuable
  config.action_view.preload_links_header = false
  config.active_record.dump_schema_after_migration = true
  config.active_record.migration_error = :page_load
  config.active_support.deprecation = :raise
  config.active_support.report_deprecations = true
  config.active_support.to_time_preserves_timezone = :zone
  config.assets.compile = true
  config.assets.quiet = true
  config.cache_store = :null_store
  config.consider_all_requests_local = true
  config.eager_load = false
  config.enable_reloading = true
  config.filter_parameters = %i[passw]
  config.i18n.available_locales = %i[en]
  config.i18n.default_locale = :en
  config.i18n.fallbacks = false
  config.i18n.raise_on_missing_translations = true
  config.log_level = ENV.fetch "LOG_LEVEL", :debug
  config.session_store :cookie_store, key: "auth", same_site: :strict, secure: false
  config.time_zone = "Etc/UTC"
  config.action_dispatch.default_headers = {
    "Referrer-Policy" => "no-referrer",
    "X-Content-Type-Options" => "nosniff",
    "X-Permitted-Cross-Domain-Policies" => "none"
  }
  [
    ActionDispatch::PermissionsPolicy::Middleware, ActionDispatch::RemoteIp,
    ActionDispatch::RequestId, Rack::ETag, Rack::Runtime
  ].each { |middleware| config.middleware.delete middleware }
end
