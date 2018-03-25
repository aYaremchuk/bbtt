module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_user, only: %i(show edit update destroy)

    def index
      @users = User.eager_load(:groups).where.not(id: current_user.id)
    end

    def show; end

    def new
      @user_form = ::UserForm.new
      # @user = User.new
      #   @user = User.new
      #   respond_to do |format|
      #     format.html
      #     format.js
      #   end
    end

    def edit
      @user_form = ::UserForm.new(id: @user.id)
    end

    def create
      @user_form = ::UserForm.new(user_form_params)
      if @user_form.save
        # session[:user_id] = @signup_form.user.id
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
      # respond_to do |format|
      #   if User.invite!(user_params)
      #     format.html { redirect_to admin_users_path, notice: 'User was successfully invited.' }
      #   else
      #     format.html { render :new }
      #   end
      # end
    end

    def update
      @user_form = ::UserForm.new(user_form_params.merge(id: @user.id))
      if @user_form.update
        # session[:user_id] = @signup_form.user.id
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
      # respond_to do |format|
      #   if @user.update(user_params)
      #     format.html { redirect_to admin_users_path, notice: 'user was successfully updated.' }
      #   else
      #     format.html { render :edit }
      #   end
      # end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'user was successfully destroyed' }
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

    def user_form_params
      params.require(:user_form).permit(:email, :first_name, :last_name, :role, group_ids: [])
    end
  end
end
