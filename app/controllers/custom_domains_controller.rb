class CustomDomainsController < ApplicationController
  def router
    # remove the leading "/" which breaks things
    self.env["REQUEST_PATH"].slice!(0)
    property = Property.find_by_custom_domain(self.env["REQUEST_PATH"])

    if property
      redirect_to property.site
    else
      flash[:danger] = "That custom domain is not registered in our system."
      redirect_to root_path
    end
  end
end
