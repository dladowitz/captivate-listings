require 'rails_helper'

describe Download do
  it { should belong_to :property }
  it { should belong_to :user }
  it { should belong_to :disclosure }
  it { should validate_presence_of :disclosure_id }
  it { should validate_presence_of :property_id }
  it { should validate_presence_of :user_id }

  it "has a valid factory" do
    download = create :download
    expect(download).to be_instance_of Download
  end
end
