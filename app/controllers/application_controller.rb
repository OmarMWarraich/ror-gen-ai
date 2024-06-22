class ApplicationController < ActionController::Base

  def authenticate_user!
    redirect_to new_session_path, alert: "You need to sign in" unless user_signed_in?
  end

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end

  def current_user
    Current.user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?
end
