require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }

  context "GET #index" do
    before { get :index }

    it 'render :index template' do
      expect(response).to render_template(:index)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context 'GET #show' do
    before { get :show, id: category.id }

    it 'render show template' do
      expect(response).to render_template(:show)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
