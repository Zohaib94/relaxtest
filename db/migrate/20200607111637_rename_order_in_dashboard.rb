# frozen_string_literal: true

class RenameOrderInDashboard < ActiveRecord::Migration[6.0]
  def change
    rename_column :dashboards, :order, :position
  end
end
