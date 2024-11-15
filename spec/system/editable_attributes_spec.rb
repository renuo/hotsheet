# frozen_string_literal: true

require "spec_helper"

RSpec.describe "editable attributes", :js do
  let!(:author) { Author.create! name: "Stephen", birthdate: "1947-09-21", gender: "male" }

  describe "update strings" do
    before do
      visit "/hotsheet"
      click_link "Author"

      wait_for_turbo
      expect(page).to have_content("Stephen") # rubocop:disable RSpec/ExpectInHook
      find(".readonly-attribute", text: "Stephen").click
      fill_in "author_name", with: "King"
    end

    it "updates attribute when pressing enter" do
      find_by_id("author_name").native.send_keys :return

      expect(page).to have_content("King")
      expect(author.reload.name).to eq("King")
    end

    it "updates attribute when clicking outside the input" do
      find("th", text: "name").click

      expect(page).to have_content("King")
      expect(author.reload.name).to eq("King")
    end
  end
end
