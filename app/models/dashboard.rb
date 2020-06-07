# frozen_string_literal: true

class Dashboard < ApplicationRecord
  acts_as_list

  belongs_to :user
  has_many :dashboard_items, dependent: :destroy

  validates :title, length: { minimum: 8, maximum: 128 }

  scope :sorted_for, ->(creator) { where(user: creator).order(:position) }
  scope :sorted_with_content_for, ->(creator) { where(user: creator).includes(:dashboard_items).order(:position) }

  accepts_nested_attributes_for :dashboard_items, allow_destroy: true, reject_if: :all_blank
end
