require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:pets).through(:pet_applications)}
  end

  it "Can create PetApplication objects from passed pet ids" do

    shelter_1 = Shelter.create!(
      name: 'FurBabies4Ever',
      address: '1664 Poplar St',
      city: 'Denver',
      state: 'CO',
      zip: '80220'
    )
    pet_1 = Pet.create!(
      name: 'Rufus',
      sex: 'male',
      age: '3',
      image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
      shelter_id: shelter_1.id,
      description: 'The cutest dog in the world. Adopt him now!'
    )
    pet_2 = Pet.create!(
      name: 'Snuggles',
      sex: 'female',
      age: '5',
      image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
      shelter_id: shelter_1.id,
      description: 'A lovable orange cat. Adopt her now!'
    )
    application = Application.create!(
      name: 'Phil',
      address: '55 whatever st',
      city: 'Denver',
      state: 'CO',
      zip: '33333',
      phone_number: '3434343434',
      description: 'some text'
    )

    pet_ids = [pet_1.id, pet_2.id]

    application.create_with_pets(pet_ids)
    expect(PetApplication.all.count).to eq(2)
    expect(PetApplication.all[0].pet_id).to eq(pet_1.id)
    expect(PetApplication.all[1].pet_id).to eq(pet_2.id)
    expect(PetApplication.all[0].application_id).to eq(application.id)
    expect(PetApplication.all[1].application_id).to eq(application.id)
  end
end
