class UserPolicy < ApplicationPolicy
  def show?
    return true if user == profile_user
  end

  private

  def profile_user
    record
  end
end
