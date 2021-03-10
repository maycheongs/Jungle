class ReviewsController < ApplicationController
  before_filter :authorize

  def authorize
    unless logged_in?
      flash[:notice] = 'Please log in to post a review.'
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews.order(created_at: :desc)
    @review = @product.reviews.new(review_params)

    @review.user = current_user
    if @review.save
      redirect_to "/products/#{params[:product_id]}"
    else
      render 'products/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
