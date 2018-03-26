require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { FactoryBot.create(:post) }
  let(:user) { FactoryBot.create(:user) }
  let(:user_with_posts) { FactoryBot.create(:user, :user_with_posts) }

  describe 'GET #index' do
    context 'not logged in' do
      it 'redirects' do
        get :index
        expect(response).to have_http_status(302)
      end
    end

    context 'logged in' do
      before { sign_in user }

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #show' do
    context 'not permitted' do
      before { sign_in user }
      it 'redirects' do
        get :show, params: { id: post.id }
        expect(response).to have_http_status(302)
      end
    end

    context 'permitted' do
      before { sign_in user_with_posts }
      it 'returns http success' do
        get :show, params: { id: Post.first.id }
        expect(response).to have_http_status(200)
      end
    end
  end
end
