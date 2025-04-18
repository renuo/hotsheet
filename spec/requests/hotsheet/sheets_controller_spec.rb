# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:user) { users(:admin) }
  let(:config) { Hotsheet.configure { sheet(:User) { row :name } } }

  before { prepare { config } }

  describe "#index" do
    it "shows a table with all values" do
      get hotsheet.users_path
      expect(response).to have_http_status :ok
      expect(response.body).to include user.name
    end
  end

  describe "#update" do
    it "updates the model" do
      expect { put hotsheet.user_path(user.id), params: { attr: :name, value: "Admin" } }
        .to change { user.reload.name }.from("Admin User").to "Admin"
    end

    context "when row is hidden" do
      it "raises an error" do
        expect { put hotsheet.user_path(user.id), params: { attr: :admin, value: false } }
          .not_to(change { user.reload.admin })
        expect(response.parsed_body["error"]).to eq "Forbidden"
      end
    end

    context "with missing params" do
      it "raises an error" do
        expect { put hotsheet.user_path(user.id) }.not_to(change { user.reload.admin })
        expect(response.parsed_body["error"]).to eq "Forbidden"
      end
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
