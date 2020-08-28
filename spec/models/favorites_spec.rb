require 'rails_helper'

describe Favorites do
  describe '#total_count' do
    it 'can calculate the total number of favorited pets it holds' do
      favorites = Favorites.new({
        '1' => 1,
        '2' => 1
      })

      expect(favorites.total_count).to eq(2)
    end

    describe "#count_of" do
      it "can count value of key" do
        favorites = Favorites.new({
          '1' => 3,
          '2' => 1
        })

        expect(favorites.count_of(1)).to eq(3)
      end


    end

    describe "#add_pet" do
      it "adds a pet to its contents" do
        favorites = Favorites.new({
          '1' => 1,
          '2' => 1
        })
        favorites.add_pet(1)
        favorites.add_pet(2)

        expect(favorites.total_count).to eq(4)
      end
    end

    describe "#extract_ids" do
      it "maps keys as integers" do
        favorites = Favorites.new({
          '1' => 1,
          '2' => 1
        })
        expect(favorites.extract_ids).to eq([1, 2])

      end
    end
  end
end
