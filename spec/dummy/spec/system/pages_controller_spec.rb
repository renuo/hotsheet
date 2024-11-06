# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::PagesController", :js do
  let!(:author) { Author.create! name: "Stephen", birthdate: "1947-09-21", gender: "male" }

  describe "update strings" do
    before do
      visit "/hotsheet"
      click_link "Author"
    end

    it "can edit attributes" do
      find(".readonly-attribute", text: "Stephen").click
      fill_in "author_name", with: "King"
      find_by_id("author_name").native.send_keys :return

      expect(page).to have_content("King")
      expect(author.reload.name).to eq("King")
    end
  end
end
