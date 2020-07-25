# frozen_string_literal: true

class CreateLogImages < ActiveRecord::Migration[6.0]
  def change
    create_table :log_images do |t|
      t.references :log_receipt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
