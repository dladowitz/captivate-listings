require 'rails_helper'

describe DownloadsController do
  before :each do
    @user       = create :user
    @property   = create :property, user: @user
    @disclosure = create :disclosure, property: @property
  end

  describe "POST index" do
    context "with valid params" do
      subject { get :index, user_id: @user, property_id: @property }

      it "renders the index template" do
        subject
        expect(response).to render_template :index
      end

      it "finds the correct user" do
        subject
        expect(assigns(:user)).to eq @user
      end

      it "finds the correct property" do
        subject
        expect(assigns(:property)).to eq @property
      end

      it "finds the property downloads" do
        @user2 = create :user
        download = @property.downloads.create(user: @user2, disclosure: @disclosure)
        subject
        expect(assigns(:downloads)).to include download
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      subject { post :create, user_id: @user, property_id: @property, disclosure_id: @disclosure }

      it "creates a new download in the database" do
        # For some reason 6 photos are created before subject runs. Not sure why.
        expect{ subject }.to change{ Download.count }.by 1
      end
    end
  end
end
