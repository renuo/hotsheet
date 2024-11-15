# frozen_string_literal: true

module CapybaraUtils
  def wait_for_turbo(timeout = nil)
    return unless has_css?(".turbo-progress-bar", visible: true, wait: 1.second)

    has_no_css?(".turbo-progress-bar", wait: timeout.presence || 5.seconds)
  end
end
