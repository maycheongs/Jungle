class Admin::DashboardController < Admin::BaseController
  def show
    @products = Product.all.order(quantity: :desc)
    @categories = Category.all
  end
end
