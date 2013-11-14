class RenameAppointmentJoinTables < ActiveRecord::Migration
  def change
    rename_table :appointment_student_tables, :appointments_students
    rename_table :appointment_teacher_tables, :appointments_teachers
  end
end
