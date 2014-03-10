class AlterTransactionMore < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.string :pay_method
    end
  end
end
