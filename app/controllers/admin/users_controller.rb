module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_user, only: %i(show edit update destroy)

    def index
      @users = User.where.not(id: current_user.id)
    end

    def show; end

    def new
      @user = User.new
      respond_to do |format|
        format.html
        format.js
      end
    end

    def edit; end

    def create
      respond_to do |format|
        if User.invite!(user_params)
          format.html { redirect_to admin_users_path, notice: 'User was successfully invited.' }
        else
          format.html { render :new }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find_by_id(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :role)
    end
  end
end
