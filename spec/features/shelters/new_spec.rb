require 'rails_helper'

RSpec.describe "New Shelter" do
  describe 'As a visitor' do
    describe 'When I visit the new shelter form' do
      it 'I can create a new shelter' do
        visit '/shelters/new'

        fill_in 'Name', with: 'Denver Animal Shelter'
        fill_in 'Address', with: '1241 W. Bayaud Ave.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80223'

        click_on 'Create Shelter'

        expect(current_path).to eq("/shelters")
        expect(page).to have_content('Denver Animal Shelter')
      end
    end
  end
end
