class AuthenticationController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to roots_path
    else
      flash[:notice] = "Opps, something went wrong!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
