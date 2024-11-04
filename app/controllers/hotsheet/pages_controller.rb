# frozen_string_literal: true

module Hotsheet
  class PagesController < ApplicationController
    def index
      @pagy, @records = pagy model.all if model
    end

    def broadcast_edit_intent
      ActionCable.server.broadcast(InlineEditChannel::STREAM_NAME, {
                                     resource_name: broadcast_params[:resource_name],
                                     resource_id: broadcast_params[:resource_id]
                                   })
    end

    def update
      record = model.find(params[:id])
      notice = "#{record} #{record.update(model_params) ? "updated successfully" : "update failed"}"

      redirect_to polymorphic_path(record), notice: notice
    end

    private

    def broadcast_params
      params.require(:broadcast).permit(:resource_name, :resource_id)
    end

    def model_params
      params.require(model.name.underscore.to_sym).permit(*model.editable_attributes)
    end

    def model
      @model ||= params[:model]&.constantize
    end
  end
end
