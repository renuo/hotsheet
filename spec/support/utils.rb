# frozen_string_literal: true

def prepare(&)
  stub_const "Rails::Server", true
  yield
  Rails.application.config.to_prepare_blocks.each(&:call)
end
