require 'rails_helper'

describe Disclosure do
  it { should belong_to :property }
  it { should validate_presence_of :title }
  it { should validate_presence_of :url }

  it "has a valid factory" do
    disclosure = create :disclosure
    expect(disclosure).to be_instance_of Disclosure
  end
end
