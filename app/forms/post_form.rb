class PostForm
  include ActiveModel::Model

  attr_accessor :id, :title, :text, :group_ids, :current_user

  validates :title, presence: true

  def initialize(params = {})
    if params[:id].present?
      @post = Post.find_by(id: params[:id])
      self.title = params[:title].nil? ? @post.title : params[:title]
      self.text = params[:text].nil? ? @post.text : params[:text]
      self.group_ids = params[:group_ids].nil? ? @post.groups.pluck(:id) : params[:group_ids]

    else
      super
    end
  end

  def save
    return false if invalid?
    begin
      ActiveRecord::Base.transaction do
        post = Post.create(post_params)
        post.groups << Group.where(id: group_ids)
        post.save!
      end

      true
    rescue e
      errors.add(:base, e.message)

      false
    end
  end

  def update
    return false if invalid?
    begin
      ActiveRecord::Base.transaction do
        @post.update_attributes(post_params.slice(:title, :text))
        @post.groups = Group.where(id: group_ids)
        @post.save!
      end

      true
    rescue e
      errors.add(:base, e.message)

      false
    end
  end

  private

  def post_params
    {
      title: title,
      text: text,
      user: current_user
    }
  end
end
