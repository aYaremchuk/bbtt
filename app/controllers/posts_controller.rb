class PostsController < ApplicationController

  def index
    # @posts = Post.joins(:groups).eager_load(:image_attachment).where('groups.id IN (?)', current_user.groups.pluck(:id)) @posts = Post.joins(:groups).eager_load(:image_attachment).where('groups.id IN (?)', current_user.groups.pluck(:id)) @posts = Post.joins(:groups).eager_load(:image_attachment).where('groups.id IN (?)', current_user.groups.pluck(:id))
    @posts = Post.joins(:groups).eager_load(:image_attachment).where('afsdfasdgroups.id IN (?)', current_user.groups.pluck(:id))
    authorize @posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    PostViewsService.new(@post, current_user).perform
    authorize @post
  end

  def user_form_params
    params.require(:user_form).permit(:first_name, :last_name, :role)
  end
end
