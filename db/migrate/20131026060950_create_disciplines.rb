class CreateDisciplines < ActiveRecord::Migration
  def change
    if !table_exists?(:disciplines)
      create_table :disciplines do |t|
        t.string :name
        t.text :description

        t.timestamps
        t.userstamps
      end
    end
  end
end
