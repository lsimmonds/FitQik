class CreateTeacherSpecialties < ActiveRecord::Migration
  def change
    create_table :teacher_specialties do |t|
      t.belongs_to :teacher
      t.belongs_to :specialty
    end
  end
end
