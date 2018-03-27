require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user_1) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:admin_1) { FactoryBot.create(:user, :admin) }

  describe 'GET #index' do
    context 'logged in' do
      before { sign_in admin }

      it 'returns an array of users' do
        get :index
        expect(assigns(:users)).to include(user, user_1, admin_1)
        expect(assigns(:users)).to_not include(admin)
      end
    end
  end
end
