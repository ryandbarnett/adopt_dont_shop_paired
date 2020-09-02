class ApplicationsController < ApplicationController

  def new
    @favorite_pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.new(application_params)
    if application.save
      application.create_with_pets(params[:adopt][:pet_ids])
      session[:favorites] -= params[:adopt][:pet_ids]
      redirect_to '/favorites'
      flash[:notice] = 'Your application for your favorited pets has been submitted'
    else
      flash[:notice] = 'Application not submitted, at least one pet must be selected and all fields completed.'
      redirect_to '/application'
    end
  end

  def index
    @pet = Pet.find(params[:pet_id])
    @pet_applications = PetApplication.where(pet_id: params[:pet_id])
  end

  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    if pet.status == "adoptable"
      pet.update(status: 'pending')
      redirect_to "/pets/#{pet.id}"
    else
      pet.update(status: 'adoptable')
      redirect_to "/applications/#{params[:application_id]}"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
