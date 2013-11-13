class CreateAppointmentTeacherTable < ActiveRecord::Migration
  def change
    create_table :appointment_teacher_tables, :id => false do |t|
      t.references :appointment
      t.references :teacher

      t.timestamps
      t.userstamps
    end
  end
end
