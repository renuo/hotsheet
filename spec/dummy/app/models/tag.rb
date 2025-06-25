# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, length: { in: 1..20 }
  validates :color, presence: true, format: { with: /\A[0-9a-f]{6}\z/ }
end
