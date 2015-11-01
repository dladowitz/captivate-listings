require 'rails_helper'

describe Site do
  it { should validate_presence_of :property_id }

  it "has a valid factory" do
    site = create :site
    expect(site).to be_instance_of Site
  end

end
