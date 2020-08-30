require 'rails_helper'

describe Pet do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :pet_applications}
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :sex}
    it { should validate_presence_of :description}
    it { should validate_presence_of :image}
    it { should validate_presence_of :age}
  end
end
