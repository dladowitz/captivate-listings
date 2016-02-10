# https://github.com/waynehoover/s3_direct_upload

class DisclosuresController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_property_and_user

  def create
    @disclosure = @property.disclosures.build disclosure_params
    @disclosure.title = params[:filename]

    if @disclosure.save
      flash[:success] = "Nice one, file(s) uploaded!"
      render :file => "disclosures/create.js.erb"
    else
      flash[:danger] = "Damn Gina, something went wrong."
      render :file => "/disclosures/create.js.erb"
    end
  end

  def index
    @disclosures = @property.disclosures
  end

  def destroy
    disclosure = Disclosure.find params[:id]
    disclosure.delete
    # TODO Use AWS gem to delete out of s3. Currently the disclosures are being orphaned.
    redirect_to user_property_disclosures_path(@user, @property)
  end

  private

  def disclosure_params
    params.require(:disclosure).permit(:property_id, :url)
  end

  def set_property_and_user
    @property = Property.find params[:property_id]
    @user = @property.user
  end
end
