require 'rails_helper'

describe PropertiesController do
  before :each do
    @user = create :user
  end

  describe "GET new" do
    subject { get :new, user_id: @user.id }
    before { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "creates a new property object" do
      expect(assigns(:property)).to be_a_new Property
    end
  end

  describe "POST create" do
    context "with valid params" do
      subject { post :create, user_id: @user.id, property: { address: "855 Front st", city: "San Francisco", state: "CA", zip: 94111, sqfeet: 1000, beds: 3, baths: 1.5 } }

      it "create a new record in the database" do
        expect{ subject }.to change{ Property.count}.by 1
      end
    end
  end

  describe "GET show" do
    let(:property) { create :property }
    subject { get :show, id: property.id, user_id: @user.id }

    it "finds the correct property in the db" do
      subject
      expect(assigns(:property)).to eq property
    end
  end
end
