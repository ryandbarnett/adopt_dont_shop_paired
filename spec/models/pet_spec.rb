require 'rails_helper'

describe Pet do
  describe 'relationships' do
    it { should have_one :shelter }
  end
  
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :sex}
    it { should validate_presence_of :description}
    it { should validate_presence_of :image}
    it { should validate_presence_of :age}
  end
end
