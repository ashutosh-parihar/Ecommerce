class HomesController < ApplicationController
  def index
    @products = Product.includes(:category).paginate(page: params[:page], per_page: 2)
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @product = current_user.products.build
  end
  def search
    @query = params[:query]

    if @query.present?
      sanitized_query = ActiveRecord::Base.sanitize_sql_like(@query)

      @products = Product.where('name LIKE ?', "%#{sanitized_query}%")
                         .limit(10)
    else
      @products = []
    end
  end

end
