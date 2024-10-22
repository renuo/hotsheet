# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsDbManager::Engine, at: "admin"
  root "application#index"
end
