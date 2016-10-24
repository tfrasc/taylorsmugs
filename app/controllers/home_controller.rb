class HomeController < ApplicationController
  def index
    @orders = Order.where(featured: true)
  end
end
