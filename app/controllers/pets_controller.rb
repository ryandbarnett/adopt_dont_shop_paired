class PetsController < ApplicationController
  def index
    if params[:id]
      @pets = Pet.select { |pet| pet.shelter_id == params[:id].to_i }
    else
      @pets = Pet.all
    end
  end
end
