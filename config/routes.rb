# frozen_string_literal: true

Hotsheet::Engine.routes.draw do
  Hotsheet.sheets.each_key do |sheet_name|
    resources sheet_name, only: %i[index update], controller: :sheets, sheet_name:
  end

  root "sheets#root"
  match "*", to: "sheets#error", via: :all
end
