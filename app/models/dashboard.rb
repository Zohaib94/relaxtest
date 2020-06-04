class Dashboard < ApplicationRecord
  belongs_to :user

  validates :order, numericality: true, uniqueness: true
  validates :title, length: { minimum: 8, maximum: 128 }

  scope :sorted_for, -> (dashboard_user) { where(user: dashboard_user).order(:order) }
end
