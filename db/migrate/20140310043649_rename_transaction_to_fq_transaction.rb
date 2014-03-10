class RenameTransactionToFqTransaction < ActiveRecord::Migration
  def change
    rename_table :transactions, :fq_transactions
  end
end
