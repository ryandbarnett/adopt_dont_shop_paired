require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')
      @review_1 = @shelter_1.reviews.create!(title: "Great Shelter!", rating: 5, content: "Has a lot of cats.", image: "catshelter1.jpeg")
      @review_2 = @shelter_1.reviews.create!(title: "Crappy Shelter!", rating: 1, content: "Not enough cats!", image: "catshelter2.jpeg")
    end

    it "can see reviews" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.title)
      expect(page).to have_xpath("//img['catshelter1.jpeg']")

      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.rating)
      expect(page).to have_content(@review_2.title)
      expect(page).to have_xpath("//img['catshelter2.jpeg']")
    end
  end
end
