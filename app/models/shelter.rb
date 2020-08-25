class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  
  validates_presence_of :name, :address, :city, :state, :zip
end
