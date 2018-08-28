class PostViewsService
  include PostsHelper

  def initialize(post, user)
    @post = post
    @user = user
  end

  def perform
    # StatsRevisionChannel.broadcast_to('test')
    update_post unless @post.views_info[@user.id.to_s].present?
  end

  private

  def update_post
    @post.views_info[@user.id] = Time.zone.now
    @post.save!
    ActionCable.server.broadcast('stats_revision', post_id: @post.id, views_stats: views_percents(@post))
  end
end
