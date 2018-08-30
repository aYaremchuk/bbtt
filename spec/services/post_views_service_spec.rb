require 'rails_helper'

describe PostViewsService do
  let(:post) { FactoryBot.create(:post) }
  let(:user) { FactoryBot.create(:user) }
  let(:views_info) {  { user.id.to_s => 1.day.ago.to_s } }
  let(:viewed_post) { FactoryBot.create(:post, views_info: views_info) }

  describe 'initialize' do
    subject { PostViewsService.new(post, user) }

    it 'sets required attributes' do
      expect(subject.instance_variable_get(:@post)).to eq(post)
      expect(subject.instance_variable_get(:@user)).to eq(user)
    end
  end

  context 'first visit' do
    let(:group) { create(:group) }

    before do
      user.groups << group
      post.groups << group
    end

    subject { PostViewsService.new(post, user).perform }

    it 'updates users views' do
      expect { subject }.to change { post.views_info.length }.from(0).to(1)
    end

    it 'send data to stats revision channel' do
      expect { subject }.to have_broadcasted_to('stats_revision').with(post_id: post.id, views_stats: '100 %')
    end
  end

  context 'second visit' do
    subject { PostViewsService.new(viewed_post, user).perform }

    it 'views info not changed' do
      expect(viewed_post.views_info.length).to eq 1
      expect(viewed_post.views_info[user.id.to_s].to_i).to eq views_info[user.id.to_s].to_i
      subject
      expect(viewed_post.views_info.length).to eq 1
      expect(viewed_post.views_info[user.id.to_s].to_i).to eq views_info[user.id.to_s].to_i
    end
  end
end
