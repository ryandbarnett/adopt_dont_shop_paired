class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} added to favorites"
  end

  def index
    @pets = favorites.contents.keys.map do |fav_id|
      Pet.find(fav_id.to_i)
    end
  end
end
