class CreateTeachers < ActiveRecord::Migration
  def change
    if !table_exists?(:admins)
      create_table :teachers do |t|
        t.references :user

        t.string :name
        t.text :bio

        t.timestamps
        t.userstamps
      end
    end
  end
end
