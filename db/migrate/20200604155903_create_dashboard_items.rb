# frozen_string_literal: true

class CreateDashboardItems < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboard_items do |t|
      t.integer :item_type, default: 0
      t.boolean :display, default: true
      t.text :content
      t.references :dashboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
