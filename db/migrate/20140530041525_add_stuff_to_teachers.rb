class AddStuffToTeachers < ActiveRecord::Migration
  def change
    add_reference :teachers, :skills, index: true
    add_reference :teachers, :specialties, index: true
    add_reference :teachers, :certifications, index: true
    add_column :teachers, :about, :string
    add_column :teachers, :text, :string
  end
end
