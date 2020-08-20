require 'rails_helper'

RSpec.describe "As a visitor" do
  it "a specific shelters information" do
    shelter_1 = Shelter.create!(name: 'FurBabies4Ever', address: '1664 Poplar St', city: 'Denver', state: 'CO', zip: '80220')
    shelter_2 = Shelter.create!(name: 'PuppyLove', address: '1665 Poplar St', city: 'Fort Collins', state: 'CA', zip: '91442')

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)

    expect(page).to_not have_content(shelter_2.name)
    expect(page).to_not have_content(shelter_2.address)
    expect(page).to_not have_content(shelter_2.city)
    expect(page).to_not have_content(shelter_2.state)
    expect(page).to_not have_content(shelter_2.zip)
  end
end
