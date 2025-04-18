# frozen_string_literal: true

def prepare(&)
  stub_const "Rails::Server", true
  Hotsheet.instance_variable_set :@sheets, nil # reset memoized sheets
  yield
end
