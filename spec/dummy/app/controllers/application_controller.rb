# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index
    redirect_to "/admin"
  end
end
