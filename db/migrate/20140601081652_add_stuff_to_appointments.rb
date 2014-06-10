class AddStuffToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :length, :integer
  end
end
