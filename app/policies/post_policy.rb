class PostPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    permission = post.groups.pluck(:id) & user.groups.pluck(:id)
    return true if permission.present?
  end

  private

  def post
    record
  end
end
