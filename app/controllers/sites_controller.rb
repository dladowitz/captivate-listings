class SitesController < ApplicationController
  layout "site_pages/site_layout"

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

  # def site_params
    # params.require(:site).permit(:id)
  # end
end
