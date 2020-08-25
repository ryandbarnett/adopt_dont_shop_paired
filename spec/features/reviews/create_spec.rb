require 'rails_helper'
# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
#
# title
# rating
# content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
RSpec.describe 'As a visitor' do
  shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')

  describe "When I visit a shelter's show page"
    it "Can click a link to add a new review" do

      visit ("/shelters/#{shelter_1.id}")
      click_on "Add a new review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/create_review")
  end
end
