# frozen_string_literal: true

module RailsDbManager
  class PagesController < ApplicationController
    def index
      @model = params[:model]&.constantize
    end

    def update
      model = model_class.find(params[:id])

      if model.update(model_params)
        redirect_to polymorphic_path(model_class), notice: "#{model_class} updated successfully"
      else
        render :index, notice: "#{model_class} update failed"
      end
    end

    private

    def model_params
      params.require(model_class.name.underscore.to_sym).permit(*model_class.editable_attributes)
    end

    def model_class
      params[:model].constantize
    end
  end
end
