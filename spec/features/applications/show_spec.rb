require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit an applications show page' do
    before :each do
      shelter = Shelter.create!(
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
        shelter_id: shelter.id,
        description: 'The cutest dog in the world. Adopt him now!'
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
      @pet_application = PetApplication.create!(application: application, pet: @pet)
    end

    it 'I can see the application name, address, city, state, zip, phone number, and description' do
      visit "/applications/#{@pet_application.id}"

      expect(page).to have_content('Name: Phil')
      expect(page).to have_content('Address: 55 whatever st')
      expect(page).to have_content('City: Denver')
      expect(page).to have_content('State: CO')
      expect(page).to have_content('Zip: 33333')
      expect(page).to have_content('Phone Number: 3434343434')
      expect(page).to have_content('Description: some text')
    end

    it "I can see names (links to pet show) of all the pet's this application is for" do
      visit "/applications/#{@pet_application.id}"

      expect(page).to have_link('Rufus')
      click_link 'Rufus'
      expect(current_path).to eq("/pets/#{@pet.id}")
    end
  end
end
