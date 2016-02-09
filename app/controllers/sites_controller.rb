class SitesController < ApplicationController
  layout "site_pages/site_layout"
  before_filter :store_location

  def show
    @site = Site.find params[:id]
    @property = @site.property
    @photos = @property.photos.order('position')
    @disclosures = @property.disclosures
    @user = @property.user

    if !@user.subscription || @user.subscription.level == 0
      @photos = @photos.limit(5)
    end
  end

  private

  def store_location
    # store last url - Use this to redirect users back to a site after they log in. 
    return unless request.get?
    return if current_user

    session[:previous_site_url] = request.fullpath
  end
end
