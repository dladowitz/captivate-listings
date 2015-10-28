require 'rails_helper'

describe Photo do
  it { should belong_to :property }
  it { should validate_presence_of :position }

  it "has a valid factory" do
    photo = create :photo
    expect(photo).to be_instance_of Photo
  end
end
