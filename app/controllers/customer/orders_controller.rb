class Customer::OrdersController < ApplicationController
  def new
    @cart = Cart.find(params[:cart_id])
    @order = Order.new
    end
end
