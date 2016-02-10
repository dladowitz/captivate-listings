require 'rails_helper'

describe DownloadsController do
  before :each do
    @user = create :user
  end

  describe "POST create" do
    context "with valid params" do
        let(:property)   { create :property }
        let(:disclosure) { create :disclosure}

        subject { post :create, user_id: @user.id, property_id: property.id, disclosure_id: disclosure.id }

      it "creates a new download in the database" do
        # For some reason 6 photos are created before subject runs. Not sure why.
        expect{ subject }.to change{ Download.count }.by 1
      end
    end
  end
end
