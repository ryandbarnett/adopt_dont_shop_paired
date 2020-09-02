class AddApprovedAppToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :approved_app, :integer
  end
end
