# frozen_string_literal: true

module DashboardsHelper
  def user_of(dashboard)
    dashboard.user.email
  end

  def displayable_text_content?(item)
    item.display && item.text_content?
  end
end
