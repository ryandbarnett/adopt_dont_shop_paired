class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new

  end

  def create
    pet = Pet.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{params[:id]}/pets"
    else
      flash[:notice] = "Pet not created, you must fill in the following fields: #{missing_pet_params}"
      redirect_to "/shelters/#{params[:id]}/pets/new"
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(update_pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:notice] = "Pet not updated, you must fill in the following fields: #{missing_pet_params}"
      redirect_to "/pets/#{params[:id]}/edit"
    end
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

  def missing_pet_params
    expected_pet_keys = [:name, :age, :sex, :image, :description]
    missing_params = expected_pet_keys.select do |param|
      pet_params[param] == "" || pet_params[param] == nil
    end
    result = missing_params.join(' ')
  end
end
