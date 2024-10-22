# frozen_string_literal: true

module RailsDbManager
  class PagesController < ApplicationController
    def index
      @models = RailsDbManager.models
    end

    def show
      params[:model].constantize.all
    end
  end
end
