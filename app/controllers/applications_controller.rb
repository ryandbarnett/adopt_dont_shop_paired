class ApplicationsController < ActionController::Base

  def new
    @favorite_pets = Pet.find(session[:favorites])
  end

  def create
    session[:favorites] -= params[:adopt][:pet_ids]
    redirect_to '/favorites'
    flash[:notice] = "Your application for your favorited pets has been submitted"
  end

  def application_params
    params.require(:application).permit(:name, :address, :city, :state, :zip, :phone_number, :description, pet_ids:[])
  end
end
