class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name
      t.text :description

      t.timestamps
      t.userstamps
    end
  end
end
