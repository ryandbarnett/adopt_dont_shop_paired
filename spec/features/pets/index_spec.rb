require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe 'when I visit the pets index page' do
    before :each do
      @shelter_1 = Shelter.create(
        name: 'FurBabies4Ever',
        address: '1664 Poplar St',
        city: 'Denver',
        state: 'CO',
        zip: '80220'
      )
      @shelter_2 = Shelter.create(
        name: 'PuppyLove',
        address: '1665 Poplar St',
        city: 'Fort Collins',
        state: 'CO',
        zip: '91442'
      )
      @pet_1 = Pet.create!(
        name: 'Rufus',
        sex: 'male',
        age: '3',
        image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
        shelter_id: @shelter_1.id,
        description: 'The cutest dog in the world. Adopt him now!',
      )
      @pet_2 = Pet.create!(
        name: 'Snuggles',
        sex: 'female',
        age: '5',
        image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
        shelter_id: @shelter_2.id,
        description: 'A lovable orange cat. Adopt her now!',
        status: 'pending'
      )
    end

    it 'I see the pets images' do
      visit '/pets'

      page.has_css?("#pet-#{@pet_1.id}")
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_css("img[src='#{@pet_1.image}']")
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_css("img[src='#{@pet_2.image}']")
      end
    end

    it 'I see the pets names' do
      visit '/pets'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
      end
    end

    it "when I click a pet name I go to that pet's show page" do
      visit '/pets'

      expect(page).to have_link(@pet_1.name)
      expect(page).to have_link(@pet_2.name)

      click_link @pet_1.name

      expect(current_path).to eq("/pets/#{@pet_1.id}")

      visit '/pets'

      click_link @pet_2.name

      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end

    it 'I see the pets sex' do
      visit '/pets'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.sex)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.sex)
      end
    end

    it 'I see the pets age' do
      visit '/pets'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.age)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.age)
      end
    end

    it 'I see the shelter name where the pet is currently located' do
      visit '/pets'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.shelter.name)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.shelter.name)
      end
    end

    it "I can see edit pet links" do
      visit '/pets'

      expect(page).to have_link("Edit Pet", count: 2)
    end

    it "when I click on an edit link I go to that pets edit page" do
      visit '/pets'

      click_link('Edit Pet', match: :first)

      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    it "I can see delete pet links" do
      visit '/pets'

      expect(page).to have_link("Delete Pet", count: 2)
    end

    it "when I click on a delete pet link I go to the pets index page and the deleted pet is gone" do
      visit '/pets'

      click_link('Delete Pet', match: :first)

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    describe 'for a specific shelter' do
      it 'I should only see pets for that shelter' do
        visit "/shelters/#{@shelter_1.id}/pets"

        expect(page).to have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)

        visit "/shelters/#{@shelter_2.id}/pets"

        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_content(@pet_1.name)
      end

      it 'I should see a create pet link' do
        visit "/shelters/#{@shelter_1.id}/pets"

        expect(page).to have_link('Create Pet')
      end

      it 'when I click the create pet link I am taken to the new pet form page' do
        visit "/shelters/#{@shelter_1.id}/pets"

        click_link 'Create Pet'

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
      end
    end

    describe "When I click to delete a pet that has an approved application" do
      it "I see a flash message stating pet cannot be deleted" do
        @pet_1.update(status: 'pending')
        visit "/pets"

        all(:link, 'Delete Pet')[0].click
        expect(current_path).to eq("/pets")
        expect(page).to have_content('Cannot delete a pet that has an approved application')
      end
    end

    describe "When I delete any pet" do
      it "If that pet was in my favorites it is removed from my favorites" do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to favorites'

        visit "/pets"

        all(:link, 'Delete Pet')[0].click
        visit "/favorites"
        expect(page).to_not have_content(@pet_1.name)
      end
    end

    describe "Every pet's shelter name is a link" do
      describe "when I click a shelters name on the pets index page" do
        it "I am taken to that shelters show page" do
        visit "/pets"

        expect(page).to have_link('FurBabies4Ever')
        expect(page).to have_link('PuppyLove')

        click_link('FurBabies4Ever')
        expect(current_path).to eq("/shelters/#{@shelter_1.id}")
        end
      end
    end
  end
end
