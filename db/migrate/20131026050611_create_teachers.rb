class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.references :user

      t.string :name
      t.text :bio

      t.timestamps
      t.userstamps
    end
  end
end
