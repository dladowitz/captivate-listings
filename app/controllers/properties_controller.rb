class PropertiesController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def new
    @user = User.find params[:user_id]
    @property = @user.properties.build
  end

  def create
    @user = User.find params[:user_id]
    @property = @user.properties.build(property_params)
    if @property.save
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
    @user = User.find params[:user_id]
    @property = Property.find params[:id]
    @photo = @property.photos.build
    @photos = @property.photos.order('position')
  end

  def confirmation

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
                                      :description, :matterport_url, :highlights, :video_walkthrough_url,
                                      :tag_line, :agent_name, :agent_phone, :agent_image_url,
                                      :agent_company, :agent_license, :agent_logo_url, :agent_website,
                                      :neighborhood_name, :neighboorhood_description, :showings)
  end
end




# class SessionsController < ApplicationController
#   def new
#     render layout: "guest_pages/guest_layout"
#   end
#
#   def create
#     @user = User.find_by_email params[:email]
#
#     if @user && @user.authenticate(params[:password])
#       session[:id] = @user.id
#
#       flash[:success] = "Welcome, #{@user.first_name}"
#       redirect_to user_path(@user)
#     else
#       flash[:danger] = "Username and/or Password dont appear to be correct"
#       redirect_to signin_path
#     end
#   end
#
#   def destroy
#     if session[:id]
#       session[:id] = nil
#       flash[:success] = "Bye Bye. Have fun storming the castle."
#     else
#       flash[:danger] = "Errr, you can't log out when you aren't logged in. That's science."
#     end
#
#     redirect_to signin_path
#   end
# end
