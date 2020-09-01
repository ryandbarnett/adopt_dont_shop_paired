class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new

  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def destroy
    pet = Pet.find(params[:id])
    unless pet.status == "pending"
      Pet.destroy(params[:id])
      redirect_to '/pets'
    else
      flash[:notice] = 'Cannot delete a pet that has an approved application'
      redirect_to '/pets'
    end
  end

  def edit

  end

  def update
    Pet.update(params[:id], update_pet_params)
    redirect_to "/pets/#{params[:id]}"
  end

  private
  def pet_params
    pet_params = params.permit(:name, :age, :sex, :image, :description, :id)
    pet_params[:shelter_id] = pet_params.delete(:id)
    pet_params
  end

  def update_pet_params
    params.permit(:name, :age, :sex, :image, :description, :id, :shelter_id)
  end
end
