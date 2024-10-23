# frozen_string_literal: true

Rails.application.routes.draw do
  mount Hotsheet::Engine, at: "admin"
  root "application#index"
end
