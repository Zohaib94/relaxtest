class LogImage < ApplicationRecord
  THUMBNAIL_WIDTH = 150
  VALID_FILE_TYPES = ["image/jpeg", "image/png"]
  MAXIMUM_IMAGE_SIZE_MB = 1

  belongs_to :log_receipt

  has_one_attached :attached_image

  validate :attached_image_validator

  def thumbnail
    return nil if attached_image.blank?
    attached_image.variant(resize_to_limit: [THUMBNAIL_WIDTH, nil])
  end

  private

  def has_image_file?
    VALID_FILE_TYPES.include?(attached_image.content_type)
  end

  def image_too_large?
    attached_image.byte_size > MAXIMUM_IMAGE_SIZE_MB.megabyte
  end

  def attached_image_validator
    errors.add(:attached_image, "is not attached") and return if attached_image.blank?
    errors.add(:attached_image, "is larger than #{MAXIMUM_IMAGE_SIZE_MB} MB") if image_too_large?
    errors.add(:attached_image, "is not JPEG/PNG image") unless has_image_file?
  end
end
