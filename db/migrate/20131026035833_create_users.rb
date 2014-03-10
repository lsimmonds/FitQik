class CreateUsers < ActiveRecord::Migration
  def change
    if !table_exists?(:users)
      create_table :users do |t|
        t.timestamps
        t.userstamps
      end
    end
  end
end
