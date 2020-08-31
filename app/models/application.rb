class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  serialize :pet_ids, Array

  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description

  def create_with_pets(pet_ids)
    pets = Pet.find(pet_ids)
    pets.each do |pet|
      PetApplication.create(application: self, pet: pet)
    end
  end
end
