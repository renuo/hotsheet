# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  enum :status, { invisible: 0, do_not_disturb: 1, idle: 2, online: 3 }, default: :invisible

  validates :display_name, presence: true, length: { in: 1..40 }
  validates :handle, presence: true, length: { in: 1..20 }, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  validates :status, presence: true
end
