class CreateAppointmentStudentTable < ActiveRecord::Migration
  def change
    create_table :appointment_student_tables, :id => false  do |t|
      t.references :appointment
      t.references :student

      t.timestamps
      t.userstamps
    end
  end
end
