class PhotosController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    @property = Property.find params[:property_id]
    @photo = @property.photos.build photo_params
    if @photo.save
      flash[:success] = "Nice one, photo created!"
      render :file => "/properties/create.js.erb"
      # redirect_to @property
    else
      flash[:danger] = "Damn Gina, something went wrong."
      # redirect_to @property
      render :file => "/properties/create.js.erb"
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:property_id, :position, :url)
  end
end
