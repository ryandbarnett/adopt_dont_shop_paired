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


  def delete
    session[:favorites].delete(params[:pet_id])
    redirect_to '/favorites'
  end

  def destroy
    session[:favorites] = nil
    render :index
  end
end
