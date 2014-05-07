class CreateTeachers < ActiveRecord::Migration
  def down
    if table_exists?(:teachers)
      drop_table :teachers
    end
  end

  def up
    if !table_exists?(:teachers)
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
