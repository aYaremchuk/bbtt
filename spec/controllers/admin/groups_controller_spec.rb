require 'rails_helper'

RSpec.describe Admin::GroupsController, type: :controller do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:group) { FactoryBot.create(:group) }

  before { sign_in admin }

  describe 'GET #index' do
    context 'logged in' do
      it 'returns an array of groups' do
        get :index
        expect(assigns(:groups)).to include(group)
      end
    end
  end

  describe 'GET #new' do
    context 'logged in' do
      it 'build new group' do
        get :new
        expect(assigns(:group)).to be_a_new(Group)
      end
    end
  end

  describe 'GET #edit' do
    context 'logged in' do
      it 'edit group' do
        get :edit, params: { id: group.id }
        expect(assigns(:group)).to be_a(Group)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: group.id } }

    it 'should delete' do
      expect(subject).to redirect_to(admin_groups_path)
      expect(Group.count).to eq 0
    end
  end

  describe 'POST #create' do
    context 'success' do
      it 'should create' do
        expect(Group.count).to eq 0
        post :create, params: { group: attributes_for(:group) }
        expect(response).to redirect_to(admin_group_path(Group.first))
        expect(Group.count).to eq 1
        expect(flash[:notice]).to eq('Group was successfully created.')
      end
    end

    context 'fail' do
      it 'creates unsuccessful' do
        expect(Group.count).to eq 0
        post :create, params: { group: attributes_for(:group, name: '') }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      it 'update' do
        group
        expect(Group.count).to eq 1
        patch :update, params: { id: group.id,
                                 group: { name: 'new name' } }
        expect(response).to redirect_to(admin_group_path(group))
        expect(Group.count).to eq 1
        group.reload
        expect(group.name).to eq 'new name'
        expect(flash[:notice]).to eq('Group was successfully updated.')
      end
    end

    context 'fail' do
      it 'updates unsuccessful' do
        group
        expect(Group.count).to eq 1
        patch :update, params: { id: group.id,
                                 group: attributes_for(:group, name: '') }
        expect(response).to render_template(:edit)
      end
    end
  end
end
