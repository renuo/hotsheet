# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet
  before_action :set_column, only: :update

  def index
    @columns = @sheet.columns
    @cells = @sheet.cells_for(@columns)
  end

  def update
    resource = @sheet.model.find_by(id: params[:id])
    return respond t("hotsheet.errors.not_found") if resource.nil?
    return respond if resource.update @column.name => params[:value]

    respond resource.errors.full_messages.first
  end

  def error
    render "error", status: :not_found
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end

  def set_column
    @column = @sheet.columns.find { |column| column.name == params[:column_name] }
    return respond t("hotsheet.errors.not_found") if @column.nil?

    respond t("hotsheet.errors.forbidden") unless @column.editable?
  end

  def respond(message = "")
    respond_to { |format| format.any { render json: message.to_json } }
  end
end
