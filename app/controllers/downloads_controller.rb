class DownloadsController < ApplicationController
  def create
    property = Property.find params[:property_id]
    download = property.downloads.create download_params
    download.user_id = params[:user_id]
    download.save
    # if only AJAX call, don't need render
    render :nothing => true
  end


  private

  def download_params
    params.require(:download).permit(:property_id, :title, :url)

  end
end
