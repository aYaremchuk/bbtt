require 'rails_helper'

describe PostForm do
  let(:user) { FactoryBot.create(:user) }
  describe 'initialize' do
    let(:post) { FactoryBot.create(:post) }

    subject(:new) { PostForm.new }
    subject(:new_filled) { PostForm.new(attributes_for(:post)) }
    subject(:existing) { PostForm.new(id: post.id) }

    it 'empty post' do
      expect(new.id).to be_nil
      expect(new.title).to be_nil
      expect(new.text).to be_nil
    end

    it 'new user filled' do
      expect(new_filled.title).to_not be_nil
      expect(new_filled.text).to_not be_nil
    end

    it 'set variable to existing post' do
      expect(existing.instance_variable_get(:@post)).to eq post
    end
  end

  describe 'save' do
    context 'failure' do
      subject { PostForm.new(attributes_for(:post)).save }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'success' do
      let(:group) { FactoryBot.create(:group) }
      let(:group1) { FactoryBot.create(:group, name: 'Group1') }

      subject(:post_without_group) { PostForm.new(attributes_for(:post).merge(current_user: user)).save }
      subject(:post_with_group) do
        PostForm.new(attributes_for(:post)
                         .merge(current_user: user, group_ids: [group.id]))
                .save
      end

      it 'creates post record' do
        expect(Post.count).to eq 0
        expect(post_without_group).to be_truthy
        expect(Post.count).to eq 1
        expect(Post.first.groups).to be_empty
      end

      it 'creates post with group' do
        expect(Post.count).to eq 0
        expect(post_with_group).to be_truthy
        expect(Post.count).to eq 1
        expect(Post.first.groups.count).to eq 1
        expect(Post.first.groups).to include(group)
      end
    end
  end

  describe 'update' do
    let(:post) { FactoryBot.create(:post) }

    subject do
      PostForm.new(id: post.id,
                   title: 'new title',
                   text: 'new text',
                   current_user: user.id)
              .update
    end

    it 'updates attributes' do
      expect(subject).to eq true
      post.reload
      expect(post.title).to eq 'new title'
      expect(post.text).to eq 'new text'
    end
  end
end
