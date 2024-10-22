# frozen_string_literal: true

module RailsDbManager
  class PagesController < ApplicationController
    def index
      @models = RailsDbManager.models
    end

    def show
      model_class = params[:model].constantize
      editable_columns = model_class.editable_columns

      @model_attributes = model_class.all.map { |model| model.attributes.slice(*editable_columns) }
    end
  end
end
