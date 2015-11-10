class PhotosController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_property_and_user

  def create
    @photo = @property.photos.build photo_params
    if @photo.save
      flash[:success] = "Nice one, photo created!"
      render :file => "/properties/create.js.erb"
    else
      flash[:danger] = "Damn Gina, something went wrong."
      render :file => "/properties/create.js.erb"
    end
  end

  def index
    @photos = @property.photos.order('position')
  end

  def destroy
    photo = Photo.find params[:id]
    photo.delete
    # TODO Use AWS gem to delete out of s3. Currently the photos are being orphaned. 
    redirect_to user_property_photos_path(@user, @property)
  end

  private

  def photo_params
    params.require(:photo).permit(:property_id, :position, :url)
  end

  def set_property_and_user
    @property = Property.find params[:property_id]
    @user = @property.user
  end
end
