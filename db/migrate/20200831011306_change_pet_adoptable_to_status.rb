class ChangePetAdoptableToStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :adoptable
    add_column :pets, :status, :string, default: 'adoptable'
  end
end
