require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:post_record) { FactoryBot.create(:post) }

  before { sign_in admin }

  describe 'GET #index' do
    context 'logged in' do
      it 'returns an array of posts' do
        get :index
        expect(assigns(:posts)).to include(post_record)
      end
    end
  end

  describe 'GET #new' do
    context 'logged in' do
      it 'build new post' do
        get :new
        expect(assigns(:post_form)).to be_a(PostForm)
      end
    end
  end

  describe 'GET #edit' do
    context 'logged in' do
      it 'edit post' do
        get :edit, params: { id: post_record.id }
        expect(assigns(:post_form)).to be_a(PostForm)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: post_record.id } }

    it 'should delete' do
      expect(subject).to redirect_to(admin_posts_path)
      expect(Post.count).to eq 0
    end
  end

  describe 'POST #create' do
    before { allow(controller).to receive_messages(current_user: admin) }
    context 'success' do
      it 'should create' do
        expect(Post.count).to eq 0
        post :create, params: { post_form: attributes_for(:post) }
        expect(response).to redirect_to(admin_posts_path)
        expect(Post.count).to eq 1
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
    end
  end

  describe 'PATCH #update' do
    before { allow(controller).to receive_messages(current_user: admin) }
    context 'success' do
      it 'update' do
        post_record
        expect(Post.count).to eq 1
        patch :update, params: { id: post_record.id, post_form: { title: 'new title' } }
        expect(response).to redirect_to(admin_posts_path)
        expect(Post.count).to eq 1
        post_record.reload
        expect(post_record.title).to eq 'new title'
        expect(flash[:notice]).to eq('Post was successfully updated.')
      end
    end
  end
end
