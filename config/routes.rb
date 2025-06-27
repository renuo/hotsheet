# frozen_string_literal: true

Hotsheet::Engine.routes.draw do
  next unless defined? Rails::Server

  root "home#show"

  Hotsheet.sheets.each_key do |sheet_name|
    resources sheet_name, sheet_name:, controller: :sheets, only: %i[index update]
  end

  match "*path", to: "home#error", via: :all
end
