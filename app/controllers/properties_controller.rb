class PropertiesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_user, except: :sort
  before_action :set_property, only: [:show, :edit, :update, :update_images]

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
    
    @disclosures = @property.disclosures

    if !@user.subscription || @user.subscription.level == 0
      @photos = @photos.limit(5)
    end
  end

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
    when "custom_domain"
      render :custom_domain_details_form
    end
  end

  #TODO Should probably break this up. Maybe make a status method
  # It's getting, its getting, it's getting kinda hectic. (I've got the powwa)
  def update
    if params[:property][:enabled] == "false"
      @property.update_attributes(enabled: false)
      flash[:danger] = "Property has been disabled!"
      redirect_to user_path(@user)
    elsif params[:property][:enabled] == "true"
      if @user.can_add_or_enable_properties?
        @property.update_attributes(enabled: true)
        flash[:success] = "Property has been enabled!"
      else
        flash[:danger] = "Over Subscription Limit. Upgrade your subscription or disable a property"
      end
      redirect_to user_path(@user)
    elsif @property.update_attributes(property_params)
      flash[:success] = "Awesome, the property has been updated!"
      if params[:update_image] == "yes"
        redirect_to edit_user_property_path(@user, @property, detail_section: "agent")
      elsif params[:property][:enabled] == false
        redirect_to user_path(@user)
      else
        redirect_to user_property_path(@user, @property)
      end
    else
      flash[:danger] = "Something has gone all wrong."
      render :update
    end
  end

  def update_images
    if @property.update_attributes(property_params)
      case params[:update_section]
      when "agent_image"
        render :file => "/properties/update_agent_image.js.erb"
      when "main_background_image"
        render :file => "/properties/update_main_background_image.js.erb"
      when "neighborhood_background_image"
        render :file => "/properties/update_neighborhood_background_image.js.erb"
      when "contact_us_background_image"
        render :file => "/properties/update_contact_background_image.js.erb"
      end
    else
      flash[:danger] = "Something has gone wrong"
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
                                      :neighborhood_name, :neighborhood_description, :main_background_image_url, :neighborhood_background_image_url, :contact_background_image_url,
                                      :custom_domain)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_property
    @property = Property.find params[:id]
  end
end
