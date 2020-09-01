class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def check_applications
    if self.pets.where(status: 'pending').any?
      true
    else
      false
    end
  end

  def delete_pets
    self.pets.destroy_all
 end
end
