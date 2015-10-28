require 'rails_helper'

describe PhotosController do
  describe "POST create" do
    context "with valid params" do
        let(:property) { create :property }
        subject { post :create, property_id: property.id, photo: { position: 1, url: "https://placekitten.com/g/500/200" } }

      it "creates a new photo in the database" do
        expect{ subject }.to change{ Photo.count }.by 1
      end
    end
  end
end
