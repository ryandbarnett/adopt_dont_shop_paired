class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} added to favorites"
  end

  def index
    favorites.extract_ids
    @pets = favorites.translate_ids
  end
end
