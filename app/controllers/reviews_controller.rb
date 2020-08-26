class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created: Reviews must have a title, rating, and content"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = "Review not updated: Reviews must have a title, rating, and content"
      redirect_to "/shelters/#{review.shelter.id}/reviews/#{review.id}/edit"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
