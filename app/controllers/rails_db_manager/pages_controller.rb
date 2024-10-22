# frozen_string_literal: true

module RailsDbManager
  class PagesController < ApplicationController
    def index
      @models = RailsDbManager.models
    end

    def show
      model_class = params[:model].constantize
      editable_attributes = model_class.editable_attributes

      @model_attributes = model_class.all.map { |model| model.attributes.slice(*editable_attributes) }
    end
  end
end
