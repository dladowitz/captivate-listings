class DownloadsController < ApplicationController
  def create
    property = Property.find params[:property_id]
    disclosure = Disclosure.find params[:disclosure_id]

    download = property.downloads.create(disclosure_id: params[:disclosure_id], user_id: params[:user_id])
    # if only AJAX call, don't need render
    render :nothing => true
  end


  private
  # Not currently putting params into a download array
  # def download_params
  #   params.require(:download).permit(:property_id, :title, :url, :disclosure_id)
  #
  # end
end
