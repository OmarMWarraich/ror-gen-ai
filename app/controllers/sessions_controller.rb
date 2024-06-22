class SessionsController < ApplicationController
  def new
  end

  def destroy
    logout
    redirect_to root_url, notice: "Logged out!"
  end

  def create
    if user = User.authenticate_by(email: params[:email],password: params[:password])
      login(user)
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unauthorized
    end
  end
end
