class Customer::CartsController < ApplicationController
  def index
    @cart_items = current_user.cart_items
  end

  def new
    @cart = current_user.carts.last
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])

    if @cart_item.nil?
      @cart_item = @cart.cart_items.build(price: params[:price], quantity: 1, product_id: params[:product_id])
    else
      @cart_item.quantity += 1
    end

    if @cart_item.save
      redirect_to customer_carts_path
    else
      redirect_to products_path, alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    @cart_item = CartItem.find_by(id: params[:id])

    if @cart_item
      @cart_item.destroy
      flash[:notice] = 'Cart item was successfully deleted.'
    else
      flash[:alert] = 'Cart item not found.'
    end

    redirect_to customer_carts_path
  end

  def show
    @cart = Cart.find(params[:id])
    @cart_items = @cart.cart_items
    @total_price = calculate_total_price(@cart_items)
    respond_to do |format|
      format.html
      format.json { render json: { total_price: @total_price } }
    end
  end

  def update
    @cart_item = CartItem.find_by(id: params[:id])

    if @cart_item
      if @cart_item.update(quantity: params[:cart_item][:quantity])
        render json: { success: true, message: 'Cart item quantity updated successfully.' }
      else
        flash[:alert] = 'Failed to update cart item quantity.'
        render json: { success: false, message: 'Failed to update cart item quantity.' }
      end
    else
      flash[:alert] = 'Cart item not found.'
      render json: { success: false, message: 'Cart item not found.' }
    end
  end


  private

  def calculate_total_price(cart_items)
    total = 0.0
    cart_items.each do |cart_item|
      total += cart_item.quantity.to_f * cart_item.product.current_price.to_f
    end
    total
  end

end
