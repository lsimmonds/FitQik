class DestroyEngagementsTable < ActiveRecord::Migration
  def change
    drop_table :engagements
    drop_table :engagement_student_tables
    drop_table :engagement_teacher_tables
  end
end
