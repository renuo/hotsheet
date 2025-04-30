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
    let(:path) { hotsheet.user_path(user.id) }

    it "updates the model" do
      expect { put path, params: { row_name: :name, to: "Bob" } }
        .to change { user.reload.name }.from("Admin User").to "Bob"
    end

    context "with nonexistent row" do
      it "does not update the model" do
        expect { put path, params: { row_name: :age, to: 21 } }.not_to change(user, :reload)
      end
    end

    context "with invalid value" do
      it "does not update the model" do
        expect { put path, params: { row_name: :name, to: "B" } }.not_to change(user, :reload)
        expect(response.parsed_body["error"]).to eq "Name is too short (minimum is 2 characters)"
      end
    end

    context "with missing params" do
      it "does not update the model" do
        expect { put path }.not_to change(user, :reload)
        expect { put path, params: { row_name: :name } }.not_to change(user, :reload)
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
