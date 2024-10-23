# frozen_string_literal: true

Hotsheet::Engine.routes.draw do
  root to: "pages#index"

  post :broadcast_edit_intent, to: "pages#broadcast_edit_intent"

  Hotsheet.models.each do |model|
    resources model.name.downcase.pluralize.to_sym, controller: "pages", only: %i[index update], model: model.name
  end
end
