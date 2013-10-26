class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user

      t.string :name

      t.timestamps
      t.userstamps
    end
  end
end
