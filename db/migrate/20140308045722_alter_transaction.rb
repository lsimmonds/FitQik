class AlterTransaction < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.string :external_id
      t.change :processor, :string
      t.string :description
      t.text :pay_object
    end
  end
end
