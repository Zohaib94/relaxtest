# frozen_string_literal: true

module DashboardsHelper
  def user_of(dashboard)
    dashboard.user.email
  end
end
