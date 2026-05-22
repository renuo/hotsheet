# frozen_string_literal: true

class Hotsheet::Column
  include Hotsheet::Config

  attr_reader :config

  CONFIG = {
    editable: { allowed_classes: [FalseClass, Proc], default: true },
    type: { allowed_classes: [Symbol], default: nil },
    visible: { allowed_classes: [FalseClass, Proc], default: true }
  }.freeze

  def initialize(config)
    @config = merge_config! CONFIG, config
  end

  def editable?
    is? :editable
  end

  def type
    @config[:type]
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
