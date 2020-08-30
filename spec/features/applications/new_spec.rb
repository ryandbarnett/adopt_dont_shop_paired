require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I've added pets to my favorites and visit my favorites page" do
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

    it "I can see a link for adopting my favorited pets" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      expect(page).to have_button('Apply to adopt')
    end

    it "When I click the link I am taken to a new application form" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit "/favorites"

      click_button 'Apply to adopt'
      expect(current_path).to eq('/application')
    end

    it "I can see a list of pets I can select from at the top of the form" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to favorites'

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to favorites'

      visit '/application'
      expect(page).to have_content('Rufus')
      expect(page).to have_content('Snuggles')
      # need to test for presence of checkbox
    end

    describe "When I select pets and fill out the form" do
      describe "I click on the submit application button" do
        describe "I'm taken back to my favorites page" do
          describe "I see a flash message indicating successful submission" do
            it "I do not see the pets I applied for" do
              visit "/pets/#{@pet_1.id}"

              click_button 'Add to favorites'

              visit "/pets/#{@pet_2.id}"

              click_button 'Add to favorites'

              visit '/application'
              check('Rufus')
              check('Snuggles')
              fill_in 'Name', with: 'Phil'
              fill_in 'Address', with: '55 whatever st'
              fill_in 'City', with: 'Denver'
              fill_in 'State', with: 'CO'
              fill_in 'Zip', with: '33333'
              fill_in 'Phone number', with: '3434343434'
              fill_in 'Description', with: 'some text'
              click_button 'Submit application'

              expect(page).to have_content('Your application for your favorited pets has been submitted')
              expect(page).to have_content("You haven't favorited any pets yet.")
            end
          end
        end
      end
    end

    describe "When I select pets and fill out the form" do
      describe "I click on the submit application button" do
        describe "I'm taken back to my favorites page" do
          describe "I see a flash message indicating successful submission" do
            it "I do see the pets I have not applied for" do
              visit "/pets/#{@pet_1.id}"

              click_button 'Add to favorites'

              visit "/pets/#{@pet_2.id}"

              click_button 'Add to favorites'

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

              expect(page).to have_content('Your application for your favorited pets has been submitted')
              expect(page).to have_content("#{@pet_2.name}")
              expect(page).to_not have_content("You haven't favorited any pets yet.")
            end
          end
        end
      end
    end

    describe "When I submit an application with an empty field" do
      describe "I am redirected back to the application page" do
        it "I see a flash message indicating the form must be completed" do

          visit "/pets/#{@pet_1.id}"

          click_button 'Add to favorites'

          visit "/pets/#{@pet_2.id}"

          click_button 'Add to favorites'

          visit '/application'
          check('Rufus')
          fill_in 'Name', with: 'Phil'
          fill_in 'Address', with: '55 whatever st'
          fill_in 'City', with: 'Denver'
          fill_in 'State', with: 'CO'
          fill_in 'Zip', with: '33333'
          fill_in 'Phone number', with: '3434343434'
          click_button 'Submit application'
          expect(current_path).to eq('/application')
          expect(page).to have_content('Application not submitted, at least one pet must be selected and all fields completed.')
        end
      end
    end
  end
end
