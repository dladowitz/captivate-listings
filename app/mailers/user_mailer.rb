class UserMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

  # TODO need to change this to work in production
  # RESET_LINK_BASE = "http://localhost:3000/reset_password/"

  # Pretty sure we don't have registrations anymore
  # def registration_email(registration)
  #   @registration = registration
  #   attachments.inline['logo_handwriting.png'] = File.read('app/assets/images/logo_handwriting.png')
  #
  #   mail(to: @registration.email, subject: "Captivate Listings - Registration")
  # end

  def signup_email(user)
    @user = user
    attachments.inline['captivatelogo.png'] = File.read('app/assets/images/captivatelogo.png')

    mail(to: @user.email, subject: "Captivate Listings - Signup")
  end

  def request_password(user, token)
    @user = user
    @reset_link = root_url + "reset_password/" + token
    attachments.inline['captivatelogo.png'] = File.read('app/assets/images/captivatelogo.png')

    mail(to: @user.email, subject: "Captivate Listings - Password Reset")
  end
end
