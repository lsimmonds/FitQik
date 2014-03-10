class AddValidatedToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :validated, :boolean, { null: true, default: :null }
  end
end
