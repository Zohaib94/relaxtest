class DashboardItem < ApplicationRecord
  belongs_to :dashboard
  enum item_type: [ :text_content ]
end
