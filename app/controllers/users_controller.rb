class UsersController < ApplicationController
  before_action :set_user, only: %i(edit show update)

  def show
    authorize @user
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_form_params
    params.require(:user_form).permit(:first_name, :last_name, :role)
  end
end
