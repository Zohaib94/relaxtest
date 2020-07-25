# frozen_string_literal: true

class CreateLogReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :log_receipts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :invoiced_at
      t.float :weight
      t.float :average_diameter
      t.integer :quantity
      t.float :average_weight
      t.float :average_length
      t.float :amount

      t.timestamps
    end
  end
end
