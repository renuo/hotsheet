# frozen_string_literal: true

class Author < ApplicationRecord
  enum :gender, { male: "male", female: "female", undefined: "undefined" }, validate: true
end
