# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:user) { users(:admin) }

  before { prepare { Hotsheet.configure { sheet :User } } }

  it "updates the cell value" do
    visit hotsheet.sheets_path :users
    find(".cell", text: user.name).click.send_keys(:enter).fill_in(with: "Admin").send_keys :enter

    expect { find(".cell", text: user.email).click }
      .to change { user.reload.name }.from("Admin User").to "Admin"
  end

  context "with a text column" do
    before do
      prepare do
        Hotsheet.configure do
          sheet(:User) do
            column :name, type: :text
            column :email
          end
        end
      end
    end

    it "updates the cell value with a newline" do
      visit hotsheet.sheets_path :users
      find(".cell", text: user.name).click.send_keys(:enter).fill_in(with: "Line 1\nLine 2")

      expect { find(".cell", text: user.email).click }
        .to change { user.reload.name }.from("Admin User").to "Line 1\nLine 2"
    end
  end
end
