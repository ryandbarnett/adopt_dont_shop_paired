require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the edit shelter form page' do
    it 'I can update a shelter' do
      shelter_1 = Shelter.create(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')

      visit "/shelters/#{shelter_1.id}/edit"

      fill_in 'Name', with: 'FurBabies4Life'
      fill_in 'Address', with: '1500 Henry St'
      fill_in 'City', with: 'Aurora'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '83062'

      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_content('FurBabies4Life')
      expect(page).to have_content('1500 Henry St')
      expect(page).to have_content('Aurora')
      expect(page).to have_content('Colorado')
      expect(page).to have_content('83062')

      expect(page).to_not have_content('FurBabies4Ever')
      expect(page).to_not have_content('1664 Poplar St')
      expect(page).to_not have_content('Denver')
      expect(page).to_not have_content('CO')
      expect(page).to_not have_content('80220')
    end
    it "I see a flash message when submitting an incomplete edit form" do

      shelter_1 = Shelter.create(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')

      visit "/shelters/#{shelter_1.id}/edit"

      fill_in 'Name', with: 'FurBabies4Life'
      fill_in 'Address', with: '1500 Henry St'
      fill_in 'City', with: 'Aurora'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: ''

      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      expect(page).to have_content('Shelter update unsuccessful, form must have no empty fields')
    end
  end
end
