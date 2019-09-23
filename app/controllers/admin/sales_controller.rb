# class Admin::SalesController < ApplicationController
class Admin::SalesController < Admin::AdminController
  def index
    @sales = Sale.all
    @queried_at = Time.now.httpdate
    render :index
  end
end
