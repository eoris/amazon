require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:author) { create(:author) }

  context "GET #show" do
    before { get :show, id: author.id }

    it 'render :show template' do
      expect(response).to render_template(:show)
    end

    it "assigns author" do
      expect(assigns(:author)).not_to be_nil
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
