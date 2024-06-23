class PasswordMailer < ApplicationMailer
  default from: "artsmith@no-reply.com"
  def password_reset_request
    @name = params[:user].email.gsub(/@.*/, "")
    @email = params[:user].email
    mail to: @email, subject: "Reset your password"
  end
end
