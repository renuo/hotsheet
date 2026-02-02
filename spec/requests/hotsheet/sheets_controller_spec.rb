# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:user) { users(:admin) }
  let(:config) { Hotsheet.configure { sheet(:User) { column :name } } }

  before { prepare { config } }

  describe "#index" do
    it "shows a spreadsheet with all values" do
      get hotsheet.sheets_path :users
      expect(response).to be_successful
      expect(response.body).to include user.name
      expect(response.body).to have_no_css ".load-more"
    end

    context "with :per configured" do
      let(:config) { Hotsheet.configure { sheet(:User, per: 1) { column :name } } }
      let!(:other_user) { User.create!(name: "2nd Page", handle: "2", email: "2nd@local", admin: false) }

      it "has a button to load more" do
        get hotsheet.sheets_path :users
        expect(response.body).to include user.name
        expect(response.body).not_to include other_user.name
        expect(response.body).to include Hotsheet.t("button_load_more", count: 1, total: User.count)
      end

      it "can show the second page directly" do
        get hotsheet.sheets_path :users, page: 2
        expect(response.body).to include other_user.name
        expect(response.body).not_to include user.name
      end

      it "shows the first page if the page count is invalid" do
        get hotsheet.sheets_path :users, page: 100
        expect(response.body).to include user.name
        expect(response.body).not_to include other_user.name
        expect(response.body).to have_no_css ".load-more"
      end
    end

    context "when the sheet does not exist" do
      it "shows an error page" do
        get "/hotsheet/authors"
        expect(response).to be_not_found
        expect(response.body).to include Hotsheet.t("error_not_found")
      end
    end
  end

  describe "#update" do
    let(:path) { hotsheet.sheet_path :users, user }

    it "updates the resource" do
      expect { put path, params: { column_name: :name, value: "Bob" } }
        .to change { user.reload.name }.from("Admin User").to "Bob"
    end

    context "when the column is not editable" do
      let(:config) { Hotsheet.configure { sheet(:User) { column :name, editable: false } } }

      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "Bob" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq Hotsheet.t("error_forbidden")
      end
    end

    context "with invalid value" do
      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "B" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq "Name is too short (minimum is 2 characters)"
      end
    end

    context "with nonexistent id" do
      let(:path) { hotsheet.sheet_path :users, 0 }

      it "does not update the resource" do
        expect { put path, params: { column_name: :name, value: "Bob" } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq Hotsheet.t("error_not_found")
      end
    end

    context "with nonexistent column" do
      it "does not update the resource" do
        expect { put path, params: { column_name: :age, value: 21 } }.not_to change(user, :reload)
        expect(response.parsed_body).to eq Hotsheet.t("error_not_found")
      end
    end

    context "with missing params" do
      it "does not update the resource" do
        expect { put path }.not_to change(user, :reload)
        expect(response.parsed_body).to eq Hotsheet.t("error_not_found")
      end
    end
  end
end
