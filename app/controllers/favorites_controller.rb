class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} added to favorites"
  end

  def index
    pet_id_strings = session[:favorites].map do |key, value|
                        key.to_i
                     end
    @pets = pet_id_strings.map do |id|
              Pet.find(id)
            end
  end
end
