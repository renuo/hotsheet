# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  STATUS = { invisible: 0, do_not_disturb: 1, idle: 2, online: 3 }.freeze

  if Rails::VERSION::MAJOR >= 7
    enum :status, STATUS, default: :invisible
  else
    enum status: STATUS, _default: :invisible # rubocop:disable Rails/EnumSyntax
  end

  validates :name, presence: true, length: { in: 2..40 }
  validates :handle, presence: true, length: { in: 1..20 }, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  validates :status, presence: true
end
