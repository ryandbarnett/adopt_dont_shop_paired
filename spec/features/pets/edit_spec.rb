require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create!(
      name: 'FurBabies4Ever',
      address: '1664 Poplar St',
      city: 'Denver',
      state: 'CO',
      zip: '80220'
    )
    @pet_1 = Pet.create!(
      name: 'Rufus',
      sex: 'male',
      age: '3',
      image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
      shelter_id: @shelter_1.id,
      description: 'The cutest dog in the world. Adopt him now!'
    )
  end

  describe 'When I visit the edit pet form page' do
    it 'I can update a pet' do
      visit "/pets/#{@pet_1.id}/edit"

      fill_in 'Name', with: 'Holly'
      choose('Female')
      fill_in 'Age', with: '4'
      fill_in 'Image', with: 'https://images.unsplash.com/photo-1548658166-136d9f6a7e76?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'
      fill_in 'Description', with: 'OMG the most adorable puppy! Adopt now!'

      click_on 'Update Pet'

      expect(current_path).to eq("/pets/#{@pet_1.id}")

      expect(page).to have_content('Holly')
      expect(page).to have_content('female')
      expect(page).to have_content('4')
      expect(page).to have_css("img[src='https://images.unsplash.com/photo-1548658166-136d9f6a7e76?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80']")
      expect(page).to have_content('OMG the most adorable puppy! Adopt now!')

      expect(page).to_not have_content('Rufus')
      expect(page).to_not have_content('3')
      expect(page).to_not have_content('The cutest dog in the world. Adopt him now!')
      expect(page).to_not have_css("img[src='#{@pet_1.image}']")
    end

    describe 'If I try to submit the form with incomplete information' do
      it 'I see a flash message indicating which field(s) I am missing' do
        visit "/pets/#{@pet_1.id}/edit"

        fill_in 'Name', with: 'Holly'
        choose('Female')
        fill_in 'Age', with: ''
        fill_in 'Image', with: ''
        fill_in 'Description', with: ''

        click_on 'Update Pet'

        expect(page).to have_content('Pet not updated, you must fill in the following fields: age image description')
      end
    end
  end
end
