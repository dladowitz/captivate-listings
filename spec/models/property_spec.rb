require 'rails_helper'

describe Property do
  it { should validate_presence_of :address }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should validate_presence_of :domain_type }
  it { should validate_presence_of :domain }

  it "has a valid factory" do
    property = create :property
    expect(property).to be_instance_of Property
  end
end
