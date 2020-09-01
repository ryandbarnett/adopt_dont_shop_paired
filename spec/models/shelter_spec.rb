require 'rails_helper'

describe Shelter do
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
    shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')
    shelter_2 = Shelter.create!(name: 'PuppyLove', address: '16 Washington Blvd', city: 'Los Angeles', state: 'CA', zip: '91442')

    pet_1 = shelter_1.pets.create!(
      name: 'Rufus',
      sex: 'male',
      age: '3',
      image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
      description: 'The cutest dog in the world. Adopt him now!',
      status: 'pending'
    )
    pet_2 = shelter_1.pets.create!(
      name: 'Snuggles',
      sex: 'female',
      age: '5',
      image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
      description: 'A lovable orange cat. Adopt her now!'
    )
    pet_3 = shelter_2.pets.create!(
      name: 'Snuggles',
      sex: 'female',
      age: '5',
      image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
      description: 'A lovable orange cat. Adopt her now!'
    )
    expect(shelter_1.check_applications).to eq(true)
    expect(shelter_2.check_applications).to eq(false)
  end
end
