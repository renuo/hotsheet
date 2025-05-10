# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:user) { users(:admin) }
  let(:config) { Hotsheet.configure { sheet(:User) { column :name } } }

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

    it "updates the resource" do
      expect { put path, params: { column_name: :name, value: "Bob" } }
        .to change { user.reload.name }.from("Admin User").to "Bob"
    end

    context "when column is not editable" do
      let(:config) { Hotsheet.configure { sheet(:User) { column :name, editable: false } } }

      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "Bob" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq I18n.t("hotsheet.errors.forbidden")
      end
    end

    context "with invalid value" do
      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "B" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq "Name is too short (minimum is 2 characters)"
      end
    end

    context "with nonexistent id" do
      let(:path) { hotsheet.user_path(0) }

      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "Bob" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq I18n.t("hotsheet.errors.not_found")
      end
    end

    context "with nonexistent column" do
      it "does not update the resource" do
        expect { put path, params: { column_name: :age, value: 21 } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq I18n.t("hotsheet.errors.not_found")
      end
    end

    context "with missing params" do
      it "does not update the resource" do
        expect { put path }.not_to change(user, :reload)
        expect(response.parsed_body).to eq I18n.t("hotsheet.errors.not_found")
      end
    end
  end

  describe "#error" do
    it "shows an error page" do
      get "/hotsheet/authors"
      expect(response).to have_http_status :not_found
      expect(response.body).to include I18n.t("hotsheet.not_found")
    end
  end
end
