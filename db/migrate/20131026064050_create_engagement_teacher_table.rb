class CreateEngagementTeacherTable < ActiveRecord::Migration
  def change
    create_table :engagement_teacher_tables, :id => false do |t|
      t.references :engagement
      t.references :teacher

      t.timestamps
      t.userstamps
    end
  end
end
