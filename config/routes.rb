# frozen_string_literal: true

Hotsheet::Engine.routes.draw do
  root "home#show"

  scope ":sheet_name" do
    resources controller: :sheets, only: %i[index update], as: :sheets
  end

  match "*path", to: "home#error", via: :all
end
