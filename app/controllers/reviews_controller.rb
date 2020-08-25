class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created: Reviews must have a title, rating, and content"
      render :new
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
