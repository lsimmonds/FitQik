class CreateTeacherCertifications < ActiveRecord::Migration
  def change
    create_table :teacher_certifications do |t|
      t.belongs_to :teacher
      t.belongs_to :certification
    end
  end
end
