class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.userstamps
    end
  end
end
