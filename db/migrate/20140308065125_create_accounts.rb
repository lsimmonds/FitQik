class CreateAccounts < ActiveRecord::Migration
  def change
    if !table_exists?(:accounts)
      create_table :accounts do |t|
        t.string :name
        t.string :description

        t.userstamps
        t.timestamps
      end
      add_index :accounts, :name, unique: true
    end
  end
end
