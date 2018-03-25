module PostsHelper
  def form_path(post)
    post.present? ? admin_post_path(@post) : admin_posts_path
  end

  def form_method(post)
    post.present? ? :put : :post
  end

  def form_button(post)
    post.present? ? 'Edit' : 'New'
  end
end
