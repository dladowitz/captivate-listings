class LandingPagesController < ApplicationController
  # This is probably a bad idea. Need to update contact form to haml and use form_tag
  skip_before_filter :verify_authenticity_token, :only => [:contact_form]
  layout "guest_pages/guest_layout"

  def landing
    # TODO this all needs to be moved to its own controller

    domain = request.base_url

    # Checks for captivate listins domain
    if domain == "http://localhost:300" || domain == "http://www.captivatelistings.com/"
      render :landing

    # Checking to see if there is the request url matches a custom domain on a site
    else
      site = Property.find_by_custom_domain domain
      unless site
        if domain.index('www.')
          # has www in domain, remove and recheck
          domain = domain.split('www.').join
          site = Property.find_by_custom_domain domain
        else
          # doesn't have www, add and recheck
          domain = request.base_url.split("http://").last
          domain = "http://www." + domain
          site = Property.find_by_custom_domain domain
        end
      end

      if site
        redirect_to site_path(site)
      else
        flash[:danger] = "Can't find a site with that domain"
        redirect_to root_path
      end
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
