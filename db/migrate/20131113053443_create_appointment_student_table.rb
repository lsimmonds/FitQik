class CreateAppointmentStudentTable < ActiveRecord::Migration
  def change
    if !table_exists?(:appointment_student_tables)
      create_table :appointment_student_tables, :id => false  do |t|
        t.references :appointment
        t.references :student

        t.timestamps
        t.userstamps
      end
    end
  end
end
