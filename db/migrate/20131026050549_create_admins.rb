class CreateAdmins < ActiveRecord::Migration
  def change
    if !table_exists?(:admins)
      create_table :admins do |t|
        t.references :user
  
        t.string :name
        t.string :email
  
        t.timestamps
        t.userstamps
      end
    end
  end
end
