class PostViewsService
  def initialize(post, user)
    @post = post
    @user = user
  end

  def perform
    update_post unless @post.views_info[@user.id.to_s].present?
  end

  private

  def update_post
    @post.views_info[@user.id] = Time.zone.now
    @post.save!
  end
end
