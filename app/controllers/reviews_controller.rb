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
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Review not updated: Reviews must have a title, rating, and content"
      redirect_to "/shelters/#{@shelter.id}/reviews/#{review.id}/edit"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
