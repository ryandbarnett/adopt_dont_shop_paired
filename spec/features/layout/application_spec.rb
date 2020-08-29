require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit any page" do
    it "I can see a favorite indicator in the navigation bar with the count of favorited pets" do
      visit '/shelters'

      expect(page).to have_content('Favorite Pet Count: 0')
    end

    it "when I click on the favorite indicator in the nav bar I should be redirected to the favorites index page" do
      visit '/shelters'

      click_link 'Favorite Pet Count: 0'

      expect(current_path).to eq('/favorites')
    end
  end
end
