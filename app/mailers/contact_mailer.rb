class ContactMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

  def contact_us_email(message)
    @message = message
    attachments.inline['captivatelogo.png'] = File.read('app/assets/images/captivatelogo.png')

    mail(to: "david@tradecrafted.com", subject: "New Contact Us Message - Captivate Listings")
  end

end
