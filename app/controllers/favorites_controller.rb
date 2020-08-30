class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    if session[:favorites]
      session[:favorites] << params[:pet_id]
    else
      session[:favorites] = [params[:pet_id]]
    end
    flash[:notice] = "#{pet.name} added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def index
    if session[:favorites]
      @favorite_pets = Pet.find(session[:favorites])
    end
  end

  def delete
    session[:favorites].delete(params[:pet_id])
    redirect_to '/favorites'
  end

  def destroy
    if params[:pet_id]
      pet = Pet.find(params[:pet_id])
      session[:favorites] = session[:favorites].delete(pet.id)
      flash[:notice] = "#{pet.name} removed from favorites"
      redirect_to "/pets/#{pet.id}"
    else
      session[:favorites] = nil
      render :index
    end
  end
end
