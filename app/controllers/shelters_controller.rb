class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new

  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:notice] = 'Shelter not created, form must have no empty fields'
      redirect_to '/shelters/new'
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    unless shelter.applications_pending
      shelter.delete_pets
      shelter.delete_reviews
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:notice] = 'A shelter with pets that have approved applications cannot be deleted'
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = 'Shelter update unsuccessful, form must have no empty fields'
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
