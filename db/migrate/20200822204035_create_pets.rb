class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :image
      t.string :description
      t.string :age
      t.string :sex

      t.timestamps
    end
  end
end
