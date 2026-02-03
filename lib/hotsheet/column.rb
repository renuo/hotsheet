# frozen_string_literal: true

class Hotsheet::Column
  include Hotsheet::Config

  attr_reader :config

  DEFAULT_CONFIG = {
    editable: { allowed_classes: [FalseClass, Proc], default: true },
    visible: { allowed_classes: [FalseClass, Proc], default: true }
  }.freeze

  def initialize(config)
    @config = merge_config! DEFAULT_CONFIG, config
  end

  def editable?
    is? :editable
  end

  def visible?
    is? :visible
  end

  private

  def is?(permission)
    perm = @config[permission]
    perm.is_a?(Proc) ? perm.call : perm
  end
end
