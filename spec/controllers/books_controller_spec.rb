require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  context "GET #index" do
    before { get :index }

    it 'render :index template' do
      expect(response).to render_template(:index)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context "GET #show" do
    before { get :show, id: book.id }

    it 'render :show template' do
      expect(response).to render_template(:show)
    end

    it "assigns book" do
      expect(assigns(:book)).not_to be_nil
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context "GET #bestsellers" do
    before { get :bestsellers }

    it 'render :bestsellers template' do
      expect(response).to render_template(:bestsellers)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
