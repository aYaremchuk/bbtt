require 'rails_helper'

RSpec.describe Admin::DashboardsController, type: :controller do
  let(:post) { FactoryBot.create(:post) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user_with_posts) { FactoryBot.create(:user, :user_with_posts) }

  describe 'GET #index' do
    context 'logged in' do
      before { sign_in admin }

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
