class PasswordMailer < ApplicationMailer
  def password_reset_request
    mail to: params[:user].email, subject: "Reset your password"
  end
end
