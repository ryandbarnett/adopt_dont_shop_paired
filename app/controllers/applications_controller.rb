class ApplicationsController < ActionController::Base

  def new
    @favorite_pets = Pet.find(session[:favorites])
  end

end
