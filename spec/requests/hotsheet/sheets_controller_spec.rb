# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:config) { Hotsheet.configure { sheet(:User) { row :name } } }

  before { prepare { config } }

  describe "#index" do
    it "shows a table with all values" do
      get "/hotsheet/users"
      expect(response).to have_http_status :ok
      expect(response.body).to include "Admin User"
    end
  end

  describe "#error" do
    it "shows an error page" do
      get "/hotsheet/authors"
      expect(response).to have_http_status :not_found
      expect(response.body).to include "404 Not Found"
    end
  end
end
