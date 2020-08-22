require 'rails_helper'

RSpec.describe "As a visitor" do
  describe 'When I visit a shelter show page' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: 80220)
      @shelter_2 = Shelter.create!(name: 'PuppyLove', address: '16 Washington Blvd', city: 'Los Angeles', state: 'CA', zip: 91442)
    end

    it "I can see the shelter name" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
    end

    it "I can see the shelter address" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.address)
      expect(page).to_not have_content(@shelter_2.address)
    end

    it "I can see the shelter city" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.city)
      expect(page).to_not have_content(@shelter_2.city)
    end

    it "I can see the shelter state" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.state)
      expect(page).to_not have_content(@shelter_2.state)
    end

    it "I can see the shelter zip code" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.zip)
      expect(page).to_not have_content(@shelter_2.zip)
    end

    it "I can see a button to delete the shelter" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_button('Delete Shelter')
    end

    it "when I click the delete shelter button I should be redirected to the shelters index page" do
      visit "/shelters/#{@shelter_1.id}"

      click_button 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter_1.name)
      expect(page).to_not have_button('Delete Shelter')
    end

    it "I can see a button to update the shelter" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_button('Update Shelter')
    end

    it "when I click the update shelter button I should be taken to that shelters edit form page" do
      visit "/shelters/#{@shelter_1.id}"

      click_button 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    end
  end
end
