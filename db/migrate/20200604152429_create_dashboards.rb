# frozen_string_literal: true

class CreateDashboards < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboards do |t|
      t.string :title
      t.integer :order
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
