class CreateEngagements < ActiveRecord::Migration
  def change
    if !table_exists?(:engagements)
      create_table :engagements do |t|
        t.string :name
        t.datetime :when

        t.timestamps
        t.userstamps
      end
    end
  end
end
