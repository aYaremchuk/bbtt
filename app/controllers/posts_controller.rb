class PostsController < ApplicationController
  def index
    @posts = Post.joins(:groups).eager_load(:image_attachment).where('groups.id IN (?)', current_user.groups.pluck(:id))
    authorize @posts
    # byebug
    # StatsRevisionChannel.broadcast_to('some data', 'data2')
    ActionCable.server.broadcast 'stats_revision', message: 'test new'
    # ActionCable.server.broadcast 'stats_revision',
    #                              content:  'content',
    #                              username: 'username'
  end

  def show
    @post = Post.find_by(id: params[:id])
    PostViewsService.new(@post, current_user).perform
    authorize @post
    views_percents(@post)
  end
end
