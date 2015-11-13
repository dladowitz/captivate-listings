class LandingPagesController < ApplicationController
  # This is probably a bad idea. Need to update contact form to haml and use form_tag
  skip_before_filter :verify_authenticity_token, :only => [:contact_form]
  layout "guest_pages/guest_layout"

  def landing

  end

  def contact_form
    @message = {name: params[:name], email: params[:email], body: params[:body]}
    ContactMailer.contact_us_email(@message).deliver

    render :contact_confirmation
  end

  def contact_confirmation

  end

end
