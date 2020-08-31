class ApplicationsController < ApplicationController

  def new
    @favorite_pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.new(application_params)
    if application.save
      pets = Pet.find(params[:adopt][:pet_ids])
      pets.each do |pet|
        PetApplication.create(application: application, pet: pet)
      end
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
    @pet_application = PetApplication.find(params[:id])
  end

  def update
    pet_application = PetApplication.find(params[:id])
    pet_application.pet.update(status: 'pending')
    redirect_to "/pets/#{pet_application.pet.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
