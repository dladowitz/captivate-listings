class SitesController < ApplicationController
  layout "site_pages/site_layout"

  def show
    @site = Site.find params[:id]
    @property = @site.property
    @photos = @property.photos.order('position')
  end


  private

  # def site_params
    # params.require(:site).permit(:id)
  # end
end
