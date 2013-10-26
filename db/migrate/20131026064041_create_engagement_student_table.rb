class CreateEngagementStudentTable < ActiveRecord::Migration
  def change
    create_table :engagement_student_tables, :id => false  do |t|
      t.references :engagement
      t.references :student

      t.timestamps
      t.userstamps
    end
  end
end
