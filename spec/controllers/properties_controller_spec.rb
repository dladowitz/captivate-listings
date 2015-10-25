require 'rails_helper'

describe PropertiesController do
  describe "GET new" do
    subject { get :new }
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
      subject { post :create, property: { address: "855 Front st", city: "San Francisco", state: "CA", zip: 94111 } }

      it "create a new record in the database" do
        expect{ subject }.to change{ Property.count}.by 1
      end
    end
  end

  describe "GET confirmation" do
    subject { get :confirmation }

    it "renders the confirmation template" do
      expect(response).to render_template :confirmation
    end
  end
end
