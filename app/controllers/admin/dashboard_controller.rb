class Admin::DashboardController < ApplicationController
  def show
    @updated_at = Time.now.httpdate
    @product_count = Product.count
    @category_count = Category.count
  end
end
