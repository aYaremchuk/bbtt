module UsersHelper
  def form_path(user)
    user.present? ? admin_user_path(user) : admin_users_path
  end

  def form_method(user)
    user.present? ? :put : :post
  end

  def form_button(user)
    user.present? ? 'Edit' : 'New'
  end
end
