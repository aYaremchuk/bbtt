module PostsHelper
  def post_form_path(post)
    post.present? ? admin_post_path(@post) : admin_posts_path
  end

  def post_form_method(post)
    post.present? ? :put : :post
  end

  def post_form_button(post)
    post.present? ? 'Edit' : 'New'
  end

  def views_percents(post)
    return '-' unless post.views_info.length > 0
    "#{100 * post.views_info.length / post.groups.map {|item| item.users.count}.sum} %"
  end
end
