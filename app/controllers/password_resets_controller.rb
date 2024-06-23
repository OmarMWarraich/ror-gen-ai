class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      PasswordMailer.with(user: user, token: user.generate_token_for(:password_reset)).password_reset_request.deliver_later
      redirect_to new_session_path, notice: "Password reset instructions sent"
    end
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:token])

    if @user.nil?
      redirect_to new_password_reset_path, alert: "Invalid or expired token"
    end
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:token])

    if @user && @user.update(password_reset_params)
      redirect_to new_session_path, notice: "Password reset successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
