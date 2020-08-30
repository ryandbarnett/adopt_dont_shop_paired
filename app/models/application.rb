class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  serialize :pet_ids, Array
end
