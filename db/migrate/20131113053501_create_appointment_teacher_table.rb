class CreateAppointmentTeacherTable < ActiveRecord::Migration
  def change
    if !table_exists?(:appointment_teacher_tables)
      create_table :appointment_teacher_tables, :id => false do |t|
        t.references :appointment
        t.references :teacher

        t.timestamps
        t.userstamps
      end
    end
  end
end
