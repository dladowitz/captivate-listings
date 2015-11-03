class PropertiesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_user, except: :sort
  before_action :set_property, only: [:show, :edit, :update]

  def new
    @property = @user.properties.build
  end

  def create
    @property = @user.properties.build(property_params)
    @site = @property.build_site
    if @property.save && @site.save
      #TODO Mailer should be sent asyncronously. Need to change so not to hold up the controller
      PropertyMailer.new_property_email(@property).deliver

      flash[:success] = "Awesome, lets add some property details."
      redirect_to user_property_path(@user, @property)
    else
      flash[:danger] = "Something has gone horribly wrong."
      render :new
    end
  end

  def show
    @photos = @property.photos.order('position')
  end

  # def confirmation
  #
  # end

  def edit
    case params[:detail_section]
    when "address"
      render :address_details_form
    when "property"
      render :property_details_form
    when "agent"
      render :agent_details_form
    when "neighborhood"
      render :neighborhood_details_form
    end
  end

  def update
    if @property.update_attributes(property_params)
      flash[:success] = "Awesome, the property has been updated!"
      redirect_to user_property_path(@user, @property)
    else
      flash[:danger] = "Something has gone all wrong."
      render :update
    end
  end

  # Sorts the photos on a property by position
  def sort
    params[:photo].each_with_index do |id, index|
      photo = Photo.find id
      puts "before: #{photo.position} >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      photo.update(position: index+1, id: id)
      # Photo.update_all({position: index+1}, {id: id})
      puts "after: #{photo.position} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    end
    render nothing: true
  end

  private

  def property_params
    params.require(:property).permit(
                                      :address, :city, :state, :zip, :domain_type, :domain,
                                      :list_price, :sqfeet, :beds, :baths, :cars, :garden,
                                      :description, :matterport_status, :matterport_url, :highlights, :showings, :video_walkthrough_url,
                                      :video_walkthrough_status, :tag_line, :agent_name, :agent_phone, :agent_image_url,
                                      :agent_company, :agent_license, :agent_logo_url, :agent_website,
                                      :neighborhood_name, :neighborhood_description, :main_background_image_url, :neighborhood_background_image_url, :contact_background_image_url)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_property
    @property = Property.find params[:id]
  end
end
