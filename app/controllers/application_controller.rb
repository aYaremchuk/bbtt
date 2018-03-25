class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  protect_from_forgery with: :exception, prepend: true

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:warning] ||= 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
