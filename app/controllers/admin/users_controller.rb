class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.', status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.', status: :ok
    else
      redirect_to admin_index_path, alert: 'User not found.', status: :not_found
    end
  end

  private

  def authorize_admin
    unless current_user.has_role?(:admin)
      redirect_to root_path, alert: 'You are not authorized to access this page.', status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :phone, :age, :gender, :address)
  end
end
