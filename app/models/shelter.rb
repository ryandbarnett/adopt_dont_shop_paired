class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def applications_pending
    if self.pets.where(status: 'pending').any?
      true
    else
      false
    end
  end

  def delete_reviews
    self.reviews.destroy_all
  end

  def delete_pets
    self.pets.destroy_all
  end

  def pet_count
    self.pets.count
  end

  def avg_review_rating
    if self.reviews.count > 0
      self.reviews.sum(:rating).to_f / self.reviews.count
    else
      0
    end
  end
end
