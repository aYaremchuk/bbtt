module Admin
  class ApplicationController < ::ApplicationController
    before_action :check_role

    private

    def check_role
      raise Pundit::NotAuthorizedError, "You don't have such permissions" unless current_user.admin?
    end
  end
end
