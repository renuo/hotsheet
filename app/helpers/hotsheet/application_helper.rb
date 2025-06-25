# frozen_string_literal: true

module Hotsheet::ApplicationHelper
  def sheet_path_for(sheet_name, **args)
    hotsheet.public_send :"#{sheet_name}_path", **args
  end
end
