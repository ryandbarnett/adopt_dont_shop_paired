require 'rails_helper'

RSpec.describe "As a visitor" do
    before :each do

    @shelter = Shelter.create!(
      name: 'FurBabies4Ever',
      address: '1664 Poplar St',
      city: 'Denver',
      state: 'CO',
      zip: '80220'
    )
    @pet = Pet.create!(
      name: 'Rufus',
      sex: 'male',
      age: '3',
      image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
      shelter_id: @shelter.id,
      description: 'The cutest dog in the world. Adopt him now!'
    )
    @application_1 = Application.create!(
      name: 'Phil',
      address: '55 whatever st',
      city: 'Denver',
      state: 'CO',
      zip: '33333',
      phone_number: '3434343434',
      description: 'some text'
    )
    @application_2 = Application.create!(
      name: 'Ryan',
      address: '33 different st',
      city: 'Denver',
      state: 'CO',
      zip: '33333',
      phone_number: '3434343434',
      description: 'some text'
    )
    @pet_application_1 = PetApplication.create!(application: @application_1, pet: @pet)
    @pet_application_2= PetApplication.create!(application: @application_2, pet: @pet)
  end

  describe 'When I visit a pets show page' do
    it 'I see a link to view all applications for this pet' do
      visit "/pets/#{@pet.id}"

      expect(page).to have_link('View all applications')
    end
  end

  describe 'When I click the view all applications link on a pet show page' do
    it 'Directs me to a page with the names of the pets applicants ' do

      visit "/pets/#{@pet.id}"
      click_link('View all applications')

      expect(page).to have_link('Phil')
      expect(page).to have_link('Ryan')
    end
  end

  describe 'From a pets applications index page I see names of applicants' do
    it "The names are links that take me to the application show page" do
      visit "/applications/#{@pet.id}/index"

      click_link('Phil')

      expect(current_path).to eq("/applications/#{@pet_application_1.id}")
      expect(page).to have_content('Phil')
      expect(page).to have_content('55 whatever st')
    end
  end
end
