class LandingPagesController < ApplicationController
  # This is probably a bad idea. Need to update contact form to haml and use form_tag
  skip_before_filter :verify_authenticity_token, :only => [:contact_form]
  layout "guest_pages/guest_layout"

  def landing
    # Checking to see if there is the request url matches a custom domain on a site
    domain = request.base_url
    site = Property.find_by_custom_domain domain
    
    if site
      redirect_to site_path(site)
    else
      render :landing
    end
  end

  def contact_form
    @message = {name: params[:name], email: params[:email], body: params[:body]}
    ContactMailer.contact_us_email(@message).deliver

    if params[:name].present?
      first_name = params[:name].split.first.capitalize
    end

    redirect_to "/contact_confirmation?first_name=#{first_name}"
  end

  def contact_confirmation
    @first_name = params[:first_name]
  end
end
