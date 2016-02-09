require 'rails_helper'

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

      it "finds the properties disclosures" do
        disclosure = site.property.disclosures.create(title: "TDS.pdf", url: "www.aws.com/tds.pdf")
        subject
        expect(assigns(:property).disclosures).to include disclosure
      end
    end
  end
end
