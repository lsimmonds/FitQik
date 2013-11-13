class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :name
      t.datetime :when

      t.timestamps
      t.userstamps
    end
  end
end
