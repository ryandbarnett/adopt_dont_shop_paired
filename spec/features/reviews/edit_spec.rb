require 'rails_helper'
# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
#
# title
# rating
# content
# image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
RSpec.describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create!(
      name: 'FurBabies4Ever',
      address: '1664 Poplar St',
      city: 'Denver',
      state: 'CO',
      zip: '80220'
    )
    @review_1 = @shelter_1.reviews.create!(
      title: "Great Shelter!",
      rating: 5,
      content: "Has a lot of cats.",
      image: "catshelter1.jpeg"
    )
    @review_2 = @shelter_1.reviews.create!(
      title: "Crappy Shelter!",
      rating: 1,
      content: "Not enough cats!",
      image: "catshelter2.jpeg"
    )
  end

  describe "When I go to the review edit form" do
    it "I should be able to edit a review" do
      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'Title', with: 'An Ok Shelter'
      fill_in 'Rating', with: 3
      fill_in 'Content', with: 'Has a balanced number of cats'

      click_on "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within ".shelter-reviews" do
        expect(page).to have_content('An Ok Shelter')
        expect(page).to have_content('Has a balanced number of cats')
      end
    end

    it "cannot edit a review with a field left blank" do
      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'Title', with: 'An Ok Shelter'
      fill_in 'Rating', with: 3
      fill_in 'Content', with: ''

      click_on "Update Review"

      expect(page).to have_content("Review not updated: Reviews must have a title, rating, and content")

      expect(page).to have_button('Update Review')
    end
  end
end
