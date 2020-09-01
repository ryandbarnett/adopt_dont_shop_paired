require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')
      @shelter_2 = Shelter.create!(name: 'PuppyLove', address: '16 Washington Blvd', city: 'Los Angeles', state: 'CA', zip: '91442')
    end

    it 'I can see the shelter name' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
    end

    it 'I can see the shelter address' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.address)
      expect(page).to_not have_content(@shelter_2.address)
    end

    it 'I can see the shelter city' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.city)
      expect(page).to_not have_content(@shelter_2.city)
    end

    it 'I can see the shelter state' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.state)
      expect(page).to_not have_content(@shelter_2.state)
    end

    it 'I can see the shelter zip code' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.zip)
      expect(page).to_not have_content(@shelter_2.zip)
    end

    it 'I can see a link to delete the shelter' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Delete Shelter')
    end

    it 'when I click the delete shelter link I should be redirected to the shelters index page' do
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter_1.name)
    end

    it 'I can see a link to update the shelter' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Update Shelter')
    end

    it 'when I click the update shelter link I should be taken to that shelters edit form page' do
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    end

    it 'I can see a link to go see all the shelters pets' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Shelter Pets')
    end

    it 'when I click the update shelter link I should be taken to that shelters edit form page' do
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Shelter Pets'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    end

    it 'I can see a count of pets that are at that shelter' do
      @shelter_1.pets.create!(
        name: 'Rufus',
        sex: 'male',
        age: '3',
        image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
        description: 'The cutest dog in the world. Adopt him now!',
        status: 'pending'
      )

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Total Pets At Shelter: 1')
    end


    it 'I can see links to edit reviews next to each review' do
      review_1 = @shelter_1.reviews.create!(
        title: "Great Shelter!",
        rating: 5,
        content: "Has a lot of cats.",
        image: "catshelter1.jpeg"
      )
      review_2 = @shelter_1.reviews.create!(
        title: "Crappy Shelter!",
        rating: 1,
        content: "Not enough cats!",
        image: "catshelter2.jpeg"
      )
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link("Edit Review", count: 2)
    end

    it 'When I click an edit review link I should go to the edit review form' do
      review_1 = @shelter_1.reviews.create!(
        title: "Great Shelter!",
        rating: 5,
        content: "Has a lot of cats.",
        image: "catshelter1.jpeg"
      )

      visit "/shelters/#{@shelter_1.id}"

      click_link "Edit Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{review_1.id}/edit")
    end

    it 'I can see links to delete reviews next to each review' do
      review_1 = @shelter_1.reviews.create!(
        title: "Great Shelter!",
        rating: 5,
        content: "Has a lot of cats.",
        image: "catshelter1.jpeg"
      )
      review_2 = @shelter_1.reviews.create!(
        title: "Crappy Shelter!",
        rating: 1,
        content: "Not enough cats!",
        image: "catshelter2.jpeg"
      )
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link("Delete Review", count: 2)
    end

    it "When I click link to delete review the page reloads without review" do
      review_1 = @shelter_1.reviews.create!(
        title: "Great Shelter!",
        rating: 5,
        content: "Has a lot of cats.",
        image: "catshelter1.jpeg"
      )
      review_2 = @shelter_1.reviews.create!(
        title: "Crappy Shelter!",
        rating: 1,
        content: "Not enough cats!",
        image: "catshelter2.jpeg"
      )

      visit "/shelters/#{@shelter_1.id}"

      all(:link, 'Delete Review')[0].click

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to_not have_content(review_1.attributes.values)
      expect(page).to have_content(review_2.title)
    end

    describe "If I click link to delete but it has pets with approved applications " do
      it "I see a flash message indicating the deletion failed" do
      pet_1 = @shelter_1.pets.create!(
        name: 'Rufus',
        sex: 'male',
        age: '3',
        image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
        description: 'The cutest dog in the world. Adopt him now!',
        status: 'pending'
      )
      pet_2 = @shelter_1.pets.create!(
        name: 'Snuggles',
        sex: 'female',
        age: '5',
        image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
        description: 'A lovable orange cat. Adopt her now!'
      )
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('A shelter with pets that have approved applications cannot be deleted')
      end

      describe "If I click link to delete" do
        describe "And the shelter has pets with no approved applications" do
          it "Deletes all pets and the shelter" do
            pet_1 = @shelter_1.pets.create!(
              name: 'Rufus',
              sex: 'male',
              age: '3',
              image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
              description: 'The cutest dog in the world. Adopt him now!'
            )
            pet_2 = @shelter_1.pets.create!(
              name: 'Snuggles',
              sex: 'female',
              age: '5',
              image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
              description: 'A lovable orange cat. Adopt her now!'
            )

            visit "/shelters/#{@shelter_1.id}"


            click_link 'Delete Shelter'

            visit "/shelters"

            expect(page).to_not have_content(@shelter_1.name)

            visit "/pets"

            expect(page).to_not have_content(pet_1.name)
            expect(page).to_not have_content(pet_2.name)
          end
        end
      end
    end
  end
end
