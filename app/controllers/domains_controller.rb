class DomainsController < ApplicationController

  def index
    domain = request.base_url

    # Checks for captivate listins domain
    if domain == "http://localhost:3000" || domain == "http://www.captivatelistings.com" || domain == "http://captivatelistings.com"
      render "landing_pages/landing", layout: "guest_pages/guest_layout"

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
        render "landing_pages/landing", layout: "guest_pages/guest_layout"
      end
    end
  end
end
