module Admin
  class PostsController < Admin::ApplicationController
    before_action :set_post, only: %i(show edit update destroy)

    def index
      @posts = Post.all.eager_load(:groups)
    end

    def show; end

    def new
      # @post = Post.new
      @post_form = ::PostForm.new
    end

    def edit
      @post_form = ::PostForm.new(id: @post.id)
    end

    def create
      @post_form = ::PostForm.new(post_form_params.merge(current_user: current_user))
      if @post_form.save
        # session[:user_id] = @signup_form.user.id
        redirect_to admin_posts_path, notice: 'Post was successfully created.'
      else
        render 'new'
      end
      # @post = current_user.posts.new(post_params)
      #
      # respond_to do |format|
      #   if @post.save
      #     format.html { redirect_to [:admin, @post], notice: 'Post was successfully created.' }
      #     format.json { render :show, status: :created, location: @post }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @post.errors, status: :unprocessable_entity }
      #   end
      # end
    end

    def update
      @post_form = ::PostForm.new(post_form_params.merge(current_user: current_user, id: @post.id))
      if @post_form.update
        # session[:user_id] = @signup_form.user.id
        redirect_to admin_posts_path, notice: 'Post was successfully updated.'
      else
        render 'edit'
      end
      # respond_to do |format|
      #   if @post.update(post_params.merge(user: current_user))
      #     format.html { redirect_to [:admin, @post], notice: 'Post was successfully updated.' }
      #     format.json { render :show, status: :ok, location: @post }
      #   else
      #     format.html { render :edit }
      #   end
      # end
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
