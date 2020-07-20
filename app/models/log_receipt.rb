class LogReceipt < ApplicationRecord
  THUMBNAIL_WIDTH = 150

  belongs_to :user

  has_one_attached :log_image

  def user_email
    user.email
  end

  def thumbnail
    log_image.variant(resize_to_limit: [THUMBNAIL_WIDTH, nil])
  end
end
