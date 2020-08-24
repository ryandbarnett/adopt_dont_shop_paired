# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(
  name: 'FurBabies4Ever',
  address: '1664 Poplar St',
  city: 'Denver',
  state: 'CO',
  zip: '80220'
)
Shelter.create(
  name: 'PuppyLove',
  address: '1665 Poplar St',
  city: 'Fort Collins',
  state: 'CO',
  zip: '91442'
)

shelter_1.pets.create!(
  name: 'Rufus',
  sex: 'male',
  age: '3',
  image: 'https://www.washingtonpost.com/resizer/uwlkeOwC_3JqSUXeH8ZP81cHx3I=/arc-anglerfish-washpost-prod-washpost/public/HB4AT3D3IMI6TMPTWIZ74WAR54.jpg',
  description: 'The cutest dog in the world. Adopt him now!'
)

shelter_1.pets.create!(
  name: 'Snuggles',
  sex: 'female',
  age: '5',
  image: 'https://upload.wikimedia.org/wikipedia/commons/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg',
  description: 'A lovable orange cat. Adopt her now!'
)
