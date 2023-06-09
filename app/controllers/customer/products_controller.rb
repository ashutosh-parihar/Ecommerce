class Customer::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end
  end


  def show
    @product = Product.find(params[:id])
    @cart = current_user.carts.last
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)

    if params[:product][:images].blank?
      @product.errors.add(:images, "must be attached")
      render :new, status: :unprocessable_entity
      return
    end

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])

    if params[:product][:images].blank?
      @product.errors.add(:images, "must be attached")
      render :edit, status: :unprocessable_entity
      return
    end
    @product.images.purge

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end





  def destroy
    @product = current_user.products.find(params[:id])
    @product.images.purge
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end


  private

  def product_params
    params.require(:product).permit(:name, :actual_price, :current_price, :description, :category_id, images: [])
  end
end
