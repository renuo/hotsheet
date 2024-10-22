# frozen_string_literal: true

RailsDbManager::Engine.routes.draw do
  root to: "pages#index"

  RailsDbManager.models.each do |model|
    resources model.table_name, to: "pages#show", only: :index, model: model.to_s
  end
end
