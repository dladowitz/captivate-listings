srequire 'rails_helper'

describe SitesController do
  describe "GET show" do
    context "with valid params" do
      let(:site) {create :site}
      subject { get :show, id: site.id }

      it "renders the correct template" do
        subject
        expect(response).to render_template :show
      end

      it "finds the correct property" do
        subject
        expect(assigns(:property)).to eq site.property
      end
    end
  end
end
