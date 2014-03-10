class AddIndexToTransaction < ActiveRecord::Migration
  def change
    add_index :transactions, :callback_id
  end
end
