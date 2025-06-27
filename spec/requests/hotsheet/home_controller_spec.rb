# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::HomeController do
  describe "#error" do
    it "shows an error page" do
      get "/hotsheet/invalid/route"
      expect(response).to be_not_found
      expect(response.body).to include Hotsheet.t("error_not_found")
    end
  end
end
