class PetsController < ApplicationController
  def index
    if params[:id]
      @pets = Pet.select { |pet| pet.shelter_id == params[:id].to_i }
      @shelter_id = params[:id].to_i
    else
      @pets = Pet.all
    end
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private
  def pet_params
    pet_params = params.permit(:name, :age, :sex, :image, :description, :id)
    pet_params[:shelter_id] = pet_params.delete(:id)
    pet_params
  end
end
