# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet
  before_action :set_column, only: :update
  before_action :set_resource, only: :update

  def index
    @columns = @sheet.columns
    @cells = @sheet.cells_for @columns
  end

  def update
    if @resource.update params[:column_name] => params[:value]
      respond
    else
      respond @resource.errors.full_messages.first
    end
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end

  def set_column
    @column = @sheet.columns[params[:column_name]]
    return respond Hotsheet.t "errors.not_found" if @column.nil?

    respond Hotsheet.t "errors.forbidden" unless @column.editable?
  end

  def set_resource
    @resource = @sheet.model.find_by id: params[:id]

    respond Hotsheet.t "errors.not_found" if @resource.nil?
  end

  def respond(message = "")
    respond_to { |format| format.any { render json: message.to_json } }
  end
end
