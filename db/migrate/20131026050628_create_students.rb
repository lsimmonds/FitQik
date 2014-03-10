class CreateStudents < ActiveRecord::Migration
  def change
    if !table_exists?(:students)
      create_table :students do |t|
        t.references :user

        t.string :name

        t.timestamps
        t.userstamps
      end
    end
  end
end
