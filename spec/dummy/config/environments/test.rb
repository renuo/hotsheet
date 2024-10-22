# frozen_string_literal: true

Rails.application.configure do
  config.action_controller.allow_forgery_protection = false
  config.action_controller.perform_caching = false
  config.action_controller.raise_on_missing_callback_actions = true
  config.action_dispatch.show_exceptions = :all
  config.action_view.logger = nil
  config.active_record.migration_error = :raise
  config.active_storage.service = :test
  config.active_support.deprecation = :stderr
  config.active_support.report_deprecations = true
  config.assets.quiet = true
  config.cache_store = :null_store
  config.consider_all_requests_local = true
  config.eager_load = false
  config.enable_reloading = false
  config.filter_parameters << :passw
  config.i18n.fallbacks = false
  config.i18n.raise_on_missing_translations = true
  config.log_level = :warn
end
