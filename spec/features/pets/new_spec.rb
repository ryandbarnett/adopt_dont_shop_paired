require 'rails_helper'

RSpec.describe "As a visitor" do
  describe 'When I visit the new pet form' do
    it 'I can create a new pet' do
      shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')

      visit "/shelters/#{shelter_1.id}/pets/new"

      fill_in 'Name', with: 'Rufus'
      fill_in 'Image', with: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg'
      fill_in 'Age', with: '3'
      choose('Male')
      fill_in 'Description', with: 'Doggo ipsum such treat heck h*ck he made many woofs pupperino, stop it fren sub woofer maximum borkdrive.'

      click_on 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_content('Rufus')
    end

    describe 'If I try to submit the form with incomplete information' do
      it 'I see a flash message indicating which field(s) I am missing' do
        shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')

        visit "/shelters/#{shelter_1.id}/pets/new"

        fill_in 'Image', with: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg'
        fill_in 'Description', with: 'Doggo ipsum such treat heck h*ck he made many woofs pupperino, stop it fren sub woofer maximum borkdrive.'

        click_on 'Create Pet'

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
        expect(page).to have_content('Pet not created, you must fill in the following fields: name age sex')
      end
    end
  end
end
