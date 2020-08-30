require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit my favorites index page' do
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
      @pet_2 = Pet.create!(
        name: 'Snuggles',
        sex: 'female',
        age: '5',
        image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
        shelter_id: @shelter_1.id,
        description: 'A lovable orange cat. Adopt her now!'
      )
    end

    it "I can see my favorited pets names as links and images" do

      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src='#{@pet_1.image}']")
      expect(page).to have_link(@pet_2.name)
      expect(page).to have_css("img[src='#{@pet_2.image}']")
    end

    it "I can see a remove all favorites button" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      expect(page).to have_button('Remove All Favorited Pets')
    end

    it "When I click the remove all favorites button all the favorited pets are removed" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      click_button 'Remove All Favorited Pets'

      expect(page).to have_content("You haven't favorited any pets yet.")
    end

    it "I can see no favorites message if I have no favorites" do
      visit "/favorites"

      expect(page).to have_content("You haven't favorited any pets yet.")
    end

    it "I do not see the no favorites message if I have favorites" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      expect(page).not_to have_content("You haven't favorited any pets yet.")
    end

    it "I can see a button to remove favorite next to each pet name" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_button("Remove from favorites")
      end

      within "#pet-#{@pet_2.id}" do
        expect(page).to have_button("Remove from favorites")
      end
    end

    describe 'when I click a remove favorite button' do
      it 'I no longer sees that favorite on the page' do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to favorites'

        visit '/favorites'

        click_button('Remove from favorites')

        expect(page).to_not have_content("#{@pet_1.name}")
      end

      it 'the favorite pet indicator is decremented by 1' do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to favorites'

        expect(page).to have_content('Favorite Pet Count: 1')

        visit '/favorites'

        click_button('Remove from favorites')

        expect(page).to have_content('Favorite Pet Count: 0')
      end

      it 'I should see you have not favorited any pets yet if there are no more favorites' do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to favorites'

        visit '/favorites'

        click_button('Remove from favorites')

        expect(page).to have_content("You haven't favorited any pets yet.")
      end

      describe 'After one or more applications have been created' do
        it 'I see a section on the page that has a list of pet names links that have at least one application on them' do
          # Add a favorite pet so can apply for it
          visit "/pets/#{@pet_1.id}"

          click_button 'Add to favorites'
          # Make an application for favorite pet
          visit '/application'

          check('Rufus')
          fill_in 'Name', with: 'Phil'
          fill_in 'Address', with: '55 whatever st'
          fill_in 'City', with: 'Denver'
          fill_in 'State', with: 'CO'
          fill_in 'Zip', with: '33333'
          fill_in 'Phone number', with: '3434343434'
          fill_in 'Description', with: 'some text'
          click_button 'Submit application'

          # Since should be redirected to favorites index after submit
          # Within pets with applications section
          within('#pets-with-applications') do
            # Check for Rufus link
            expect(page).to have_link('Rufus')
          end
        end
      end
    end
  end
end
