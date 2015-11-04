class PropertyMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

  def new_property_email(property)
    # TODO change out image
    @property = property
    attachments.inline['captivatelogo.png'] = File.read('app/assets/images/captivatelogo.png')

    mail(to: "david@tradecrafted.com", subject: "New Property Created - Captivate Listings")
  end

  # def registration_email(registration)
  #   @registration = registration
  #   attachments.inline['logo_handwriting.png'] = File.read('app/assets/images/logo_handwriting.png')
  #
  #   mail(to: @registration.email, subject: "Captivate Labs - Registration")
  # end
  #
  # def signup_email(user)
  #   @user = user
  #   attachments.inline['logo_handwriting.png'] = File.read('app/assets/images/logo_handwriting.png')
  #
  #   mail(to: @user.email, subject: "Captivate Labs - Signup")
  # end
  #
  # def request_password(user, token)
  #   @user = user
  #   @reset_link = RESET_LINK_BASE + token
  #   attachments.inline['logo_handwriting.png'] = File.read('app/assets/images/logo_handwriting.png')
  #
  #   mail(to: @user.email, subject: "Captivate Labs - Password Reset")
  # end
end
