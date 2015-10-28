require 'rails_helper'

describe PhotosController do
  describe "POST create" do
    subject { post :create }

    context "with valid params" do
      it "creates a new photo in the database" do
        expect{ subject }.to change{ Photo.count}.by 1
      end
    end
  end
end
