class RemoveWeightFromLogReceipts < ActiveRecord::Migration[6.0]
  def change
    remove_column :log_receipts, :weight, :float
  end
end
