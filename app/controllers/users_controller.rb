class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_signed_in
  helper_method :match_user
  before_action :require_login, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"

      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    session.clear
    flash[:notice] = "User was successfully deleted"
    redirect_to users_path
  end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confimration, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confimration)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def match_user(user)
    (current_user.memberships.pluck(:project_id) & user.memberships.pluck(:project_id)).empty?
  end

  def require_login
    unless @user.id == current_user.id || current_user.admin
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
