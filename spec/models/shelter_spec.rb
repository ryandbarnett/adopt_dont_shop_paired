require 'rails_helper'

describe Shelter do
  before :each do
    @shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')
    @shelter_1.pets.create!(
      name: 'Rufus',
      sex: 'male',
      age: '3',
      image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
      description: 'The cutest dog in the world. Adopt him now!'
    )
    @shelter_1.pets.create!(
      name: 'Snuggles',
      sex: 'female',
      age: '5',
      image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
      description: 'A lovable orange cat. Adopt her now!'
    )
    @shelter_1.reviews.create!(
      title: "Great Shelter!",
      rating: 5,
      content: "Has a lot of cats.",
      image: "catshelter1.jpeg"
    )

    @shelter_1.reviews.create!(
      title: "Crappy Shelter!",
      rating: 1,
      content: "Not enough cats!",
      image: "catshelter2.jpeg"
    )
  end

  describe 'relationships' do
    it { should have_many :pets }
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
  end

  it "Can check pet applications for approvals" do
    expect(@shelter_1.applications_pending).to eq(false)

    @shelter_1.pets[0].update(status: 'pending')

    expect(@shelter_1.applications_pending).to eq(true)
  end

  it "Can delete all reviews" do
    expect(@shelter_1.reviews.count).to eq(2)

    @shelter_1.delete_reviews

    expect(@shelter_1.reviews.empty?).to eq(true)
  end

  it "Can delete all pets" do
    @shelter_1.delete_pets
    expect(@shelter_1.pets.empty?).to eq(true)
  end

  it "Can count all pets" do
    expect(@shelter_1.pet_count).to eq(2)
  end

  it "Can average the review ratings" do
    expect(@shelter_1.avg_review_rating).to eq(3)
  end
end
