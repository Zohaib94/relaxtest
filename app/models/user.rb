# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dashboards
  has_many :log_receipts

  ROLES = {
    free: 'free',
    premium: 'premium'
  }

  enum role: ROLES
end
