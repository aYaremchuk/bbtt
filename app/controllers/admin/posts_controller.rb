module Admin
  class PostsController < Admin::ApplicationController
    before_action :set_post, only: %i(show edit update destroy)

    def index
      @posts = Post.all.eager_load(:groups).includes(:posts_groups)
    end

    def show; end

    def new
      @post_form = ::PostForm.new
    end

    def edit
      @post_form = ::PostForm.new(id: @post.id)
    end

    def create
      @post_form = ::PostForm.new(post_form_params.merge(current_user: current_user))
      if @post_form.save
        redirect_to admin_posts_path, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    def update
      @post_form = ::PostForm.new(post_form_params.merge(current_user: current_user, id: @post.id))
      if @post_form.update
        redirect_to admin_posts_path, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :text)
    end

    def post_form_params
      params.require(:post_form).permit(:title, :text, group_ids: [])
    end
  end
end
