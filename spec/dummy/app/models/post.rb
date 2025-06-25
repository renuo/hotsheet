# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true, length: { in: 2..50 }
  validates :body, presence: true, length: { in: 2..250 }
end
