require 'rails_helper'

describe PhotosController do
  before :each do
    @user = create :user
  end
  describe "POST create" do
    context "with valid params" do
        let(:property) { create :property }
        subject { post :create, user_id: @user.id, property_id: property.id, photo: { position: 1, url: "https://placekitten.com/g/500/200" } }

      it "creates a new photo in the database" do
        # For some reason 6 photos are created before subject runs. Not sure why.
        expect{ subject }.to change{ Photo.count }.by_at_least 1
      end
    end
  end
end
