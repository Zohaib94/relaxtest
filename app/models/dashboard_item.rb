# frozen_string_literal: true

class DashboardItem < ApplicationRecord
  belongs_to :dashboard

  enum item_type: [:text_content]

  has_rich_text :content
end
