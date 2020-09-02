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
  before :each do
    @shelter_1 = Shelter.create!(name: 'LottaCats', address: '5555 Street St', city: 'Denver', state: 'CO', zip: '80220')
  end

  describe "When I visit a shelter's show page"
    it "Can click a link to add a new review" do

      visit "/shelters/#{@shelter_1.id}"
      click_on "Add a new review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in 'Title', with: "Crappy Shelter!"
      fill_in 'Rating', with: 2
      fill_in 'Content', with: "So much poo!"
      fill_in 'Image', with: "catshelter1.jpeg"

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content('Crappy Shelter')
      expect(page).to have_content(2)
      expect(page).to have_content("So much poo!")
      expect(page).to have_xpath("//img['catshelter1.jpeg']")
  end

  it 'I can not create a review without a title' do
    visit "/shelters/#{@shelter_1.id}/reviews/new"

    fill_in 'Rating', with: 2
    fill_in 'Content', with: "So much poo!"
    fill_in 'Image', with: "catshelter1.jpeg"

    click_on "Submit Review"

    expect(page).to have_content("Review not created: Reviews must have a title, rating, and content")
    expect(page).to have_button('Submit Review')
  end

  describe "The name of the shelter on the new review page" do
    it "Is a link that when clicked takes me to that shelter's show page" do
      visit "/shelters/#{@shelter_1.id}/reviews/new"
      
      expect(page).to have_link('LottaCats')

      click_link('LottaCats')
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    end
  end
end
