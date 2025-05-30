# frozen_string_literal: true

Hotsheet::Engine.routes.draw do
  next if Rails::VERSION::MAJOR < 8 && !defined? Rails::Server

  Hotsheet.sheets.each_key do |sheet_name|
    resources sheet_name, sheet_name:, controller: :sheets, only: %i[index update]
  end

  root "sheets#root"
  match "*path", to: "sheets#error", via: :all
end
