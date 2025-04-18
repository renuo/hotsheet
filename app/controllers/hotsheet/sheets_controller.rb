# frozen_string_literal: true

class Hotsheet::SheetsController < Hotsheet::ApplicationController
  before_action :set_sheet

  def index
    @rows = @sheet.rows
    @cells = @sheet.model.pluck(*@rows.pluck(:name))
    @cells = @rows.length == 1 ? [@cells] : @cells.transpose
  end

  def update # rubocop:disable Metrics/AbcSize
    @sheet.update! id: params[:id], attr: params[:attr]&.to_sym, value: params[:value]
    respond_to { |format| format.any { render json: { error: false } } }
  rescue Hotsheet::Error => e
    json = { error: e.message, value: params[:prev], x: params[:x], y: params[:y] }
    respond_to { |format| format.any { render json: } }
  end

  def error
    render "error", status: :not_found
  end

  private

  def set_sheet
    @sheet = Hotsheet.sheets[params[:sheet_name]]
  end
end
