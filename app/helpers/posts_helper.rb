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

  def total_users(post)
    post.groups.map { |item| item.users.count }.sum
  end

  def views_percents(post)
    return '-' if post.views_info.empty? || total_users(post).zero?
    "#{100 * post.views_info.length / total_users(post)} %"
  end
end
