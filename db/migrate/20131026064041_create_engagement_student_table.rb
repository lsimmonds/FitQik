class CreateEngagementStudentTable < ActiveRecord::Migration
  def change
    if !table_exists?(:engagement_student_tables)
      create_table :engagement_student_tables, :id => false  do |t|
        t.references :engagement
        t.references :student

        t.timestamps
        t.userstamps
      end
    end
  end
end
