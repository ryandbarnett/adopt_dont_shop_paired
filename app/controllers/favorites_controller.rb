class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    if session[:favorites]
      session[:favorites] << params[:pet_id]
    else
      session[:favorites] = [params[:pet_id]]
    end
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} added to favorites"
  end

  def index
    if session[:favorites]
      @favorite_pets = Pet.find(session[:favorites])
    end
  end
end
