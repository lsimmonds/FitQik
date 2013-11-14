class AddSubjectToAppointment < ActiveRecord::Migration
  def change
    add_reference :appointments, :subject, index: true
  end
end
