class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :occured
      t.text :processor
      t.decimal :amount, :precision => 9, :scale => 2
      t.references :account, index: true
      t.boolean :reconciled

      t.timestamps
    end
  end
end
