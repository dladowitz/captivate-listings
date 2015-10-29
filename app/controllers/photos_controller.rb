class PhotosController < ApplicationController
  layout "guest_pages/guest_layout"

  def create
    @property = Property.find params[:property_id]
    @photo = @property.photos.build photo_params
binding.pry
    if @photo.save
      flash[:success] = "Nice one, photo created!"
      redirect_to @property
    else
      flash[:danger] = "Damn Gina, something went wrong."
      redirect_to @property
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:property_id, :position, :url)
  end
end
