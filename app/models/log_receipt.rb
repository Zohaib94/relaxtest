class LogReceipt < ApplicationRecord
  THUMBNAIL_WIDTH = 150
  VALID_FILE_TYPES = ["image/jpeg", "image/png"]
  MAXIMUM_IMAGE_SIZE_MB = 1

  belongs_to :user

  has_one_attached :log_image

  validates :invoiced_at, :amount, :quantity, presence: true
  validates :average_weight, :average_diameter, :average_length, numericality: true, allow_blank: true
  validates :amount, :quantity, numericality: true

  validate :image_attachment_validation
  validate :invoice_date_validation

  def user_email
    user.email
  end

  def thumbnail
    log_image.variant(resize_to_limit: [THUMBNAIL_WIDTH, nil])
  end

  private

  def image_attachment_validation
    errors.add(:log_image, "is not attached") and return if log_image.blank?
    errors.add(:log_image, "is larger than #{MAXIMUM_IMAGE_SIZE_MB} MB") if image_too_large?
    errors.add(:log_image, "is not JPEG/PNG image") unless has_image_file?
  end

  def invoice_date_validation
    errors.add(:invoiced_at, "is not in correct format") unless valid_invoiced_at_format?
  end

  def has_image_file?
    VALID_FILE_TYPES.include?(log_image.content_type)
  end

  def image_too_large?
    log_image.byte_size > MAXIMUM_IMAGE_SIZE_MB.megabyte
  end

  def valid_invoiced_at_format?
    Date.parse(invoiced_at&.to_s) rescue false
  end
end
