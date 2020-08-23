require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a pet show page' do
    before :each do
      @shelter_1 = Shelter.create!(
        name: 'FurBabies4Ever',
        address: '1664 Poplar St',
        city: 'Denver',
        state: 'CO',
        zip: '80220'
      )
      @shelter_2 = Shelter.create!(
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
        description: 'The cutest dog in the world. Adopt him now!'
      )
      @pet_2 = Pet.create!(
        name: 'Snuggles',
        sex: 'female',
        age: '5',
        image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
        shelter_id: @shelter_2.id,
        description: 'A lovable orange cat. Adopt her now!'
      )
    end

    it 'I can see the pet name' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_content(@pet_1.name)
      expect(page).to_not have_content(@pet_2.name)
    end

    it 'I can see the pet description' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_content(@pet_1.description)
      expect(page).to_not have_content(@pet_2.description)
    end

    it 'I can see the pet age' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_content(@pet_1.age)
      expect(page).to_not have_content(@pet_2.age)
    end

    it 'I can see the pet adoptable status' do
      skip
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_content(@pet_1.adoptable)
      expect(page).to_not have_content(@pet_2.adoptable)
    end

    it 'I can see the pet image' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_css("img[src='#{@pet_1.image}']")
      expect(page).to_not have_css("img[src='#{@pet_2.image}']")
    end
  end
end
