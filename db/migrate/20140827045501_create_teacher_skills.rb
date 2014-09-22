class CreateTeacherSkills < ActiveRecord::Migration
  def change
    create_table :teacher_skills do |t|
      t.belongs_to :teacher
      t.belongs_to :skill
    end
  end
end
