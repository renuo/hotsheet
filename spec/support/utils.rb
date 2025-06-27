# frozen_string_literal: true

def prepare(&)
  Hotsheet.instance_variable_set :@sheets, nil # reset memoized sheets
  yield
end
