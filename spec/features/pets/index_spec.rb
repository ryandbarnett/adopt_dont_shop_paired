require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "when I visit the pets index page" do
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
      @pet_1 = Pet.create(
        name: 'Rufus',
        sex: 'male',
        age: '3',
        image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
        shelter_id: @shelter_1.id,
      )
      @pet_2 = Pet.create(
        name: 'Snuggles',
        sex: 'female',
        age: '5',
        image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
        shelter_id: @shelter_2.id,
      )
    end

    it "I see the pets images" do
      visit "/pets"

      within "#pet-#{@pet_1.id}" do
        page.should have_css('img', text: @pet_1.image)
      end
      within "#pet-#{@pet_2.id}" do
        page.should have_css('img', text: @pet_2.image)
      end
    end

    it "I see the pets names" do
      visit "/pets"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
      end
    end

    it "I see the pets sex" do
      visit "/pets"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.sex)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.sex)
      end
    end

    it "I see the pets age" do
      visit "/pets"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.age)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.age)
      end
    end

    it "I see the shelter name where the pet is currently located" do
      visit "/pets"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@shelter_1.name)
      end
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@shelter_2.name)
      end
    end
  end
end
