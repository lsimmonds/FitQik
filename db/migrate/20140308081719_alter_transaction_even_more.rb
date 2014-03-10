class AlterTransactionEvenMore < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.string :callback_id
    end
  end
end
