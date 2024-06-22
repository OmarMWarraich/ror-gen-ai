class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      PasswordMailer.with(user: user, token: user.generate_token_for(:password_reset)).password_reset_request.deliver_later
    end

  end

  def edit
  end

  def update

  end

  private

  def password_reset_params
  end
end
