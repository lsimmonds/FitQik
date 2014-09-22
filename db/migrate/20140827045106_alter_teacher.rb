class AlterTeacher < ActiveRecord::Migration
  def change
    remove_reference :teachers, :skills, index: true
    remove_reference :teachers, :specialties, index: true
    remove_reference :teachers, :certifications, index: true
  end
end
