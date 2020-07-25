# frozen_string_literal: true

class LogReceipt < ApplicationRecord
  include Hashid::Rails

  belongs_to :user

  has_many :log_images, dependent: :destroy
  accepts_nested_attributes_for :log_images, allow_destroy: true

  validates :invoiced_at, :amount, :quantity, presence: true
  validates :average_weight, :average_diameter, :average_length, numericality: true, allow_blank: true
  validates :amount, :quantity, numericality: true

  validate :invoice_date_validation

  def user_email
    user.email
  end

  private

  def invoice_date_validation
    errors.add(:invoiced_at, 'is not in correct format') unless valid_invoiced_at_format?
  end

  def valid_invoiced_at_format?
    Date.parse(invoiced_at&.to_s)
  rescue StandardError
    false
  end
end
