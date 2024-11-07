# frozen_string_literal: true

module Hotsheet
  class PagesController < ApplicationController
    def index
      @pagy, @records = pagy model.all if model
    end

    def broadcast_edit_intent
      ActionCable.server.broadcast InlineEditChannel::STREAM_NAME, {
        resource_name: broadcast_params[:resource_name],
        resource_id: broadcast_params[:resource_id]
      }
    end

    def update # rubocop:disable Metrics/AbcSize
      record = model.find params[:id]

      if record.update model_params
        flash[:notice] = t("hotsheet.success", record: model.model_name.human)
      else
        flash[:alert] = t("hotsheet.error", record: model.model_name.human,
                                            errors: record.errors.full_messages.join(", "))
      end

      redirect_to "#{root_path}#{model.table_name}"
    end

    private

    def broadcast_params
      params.require(:broadcast).permit :resource_name, :resource_id
    end

    def model_params
      params.require(model.name.underscore).permit(*model.editable_attributes)
    end

    def model
      @model ||= params[:model]&.constantize
    end
  end
end
