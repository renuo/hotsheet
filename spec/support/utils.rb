# frozen_string_literal: true

def prepare(&)
  stub_const "Rails::Server", true if Rails::VERSION::MAJOR < 8
  Hotsheet.instance_variable_set :@sheets, nil # reset memoized sheets
  yield
  Rails.application.reload_routes! if Rails::VERSION::MAJOR < 8
end
