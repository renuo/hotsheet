# frozen_string_literal: true

module Hotsheet
  class PagesController < ApplicationController
    def index
      @model = model_class
    end

    def broadcast_edit_intent
      ActionCable.server.broadcast(InlineEditChannel::STREAM_NAME, {
                                     resource_name: broadcast_params[:resource_name],
                                     resource_id: broadcast_params[:resource_id]
                                   })
    end

    def update
      model = model_class.find(params[:id])
      notice = if model.update(model_params)
                 "#{model_class} updated successfully"
               else
                 "#{model_class} update failed"
               end

      redirect_to polymorphic_path(model_class), notice: notice
    end

    private

    def broadcast_params
      params.require(:broadcast).permit(:resource_name, :resource_id)
    end

    def model_params
      params.require(model_class.name.underscore.to_sym).permit(*model_class.editable_attributes)
    end

    def model_class
      params[:model]&.constantize
    end
  end
end
