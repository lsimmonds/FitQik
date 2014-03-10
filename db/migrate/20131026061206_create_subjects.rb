class CreateSubjects < ActiveRecord::Migration
  def change
    if !table_exists?(:subjects)
      create_table :subjects do |t|
        t.references :discipline

        t.string :name
        t.text :description

        t.timestamps
      end
    end
  end
end
