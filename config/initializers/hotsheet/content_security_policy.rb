# frozen_string_literal: true

Rails.application.configure do
  config.content_security_policy do |csp|
    csp.default_src :none
    csp.connect_src :self
    csp.img_src :self
    csp.script_src :strict_dynamic
    csp.style_src :self, :unsafe_inline
  end

  config.content_security_policy_nonce_directives = %w[script-src]
  config.content_security_policy_nonce_generator = ->(_) { SecureRandom.base64 18 }
end
