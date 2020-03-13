class UserForm
  include ActiveModel::Model

  attr_accessor :id, :email, :first_name, :last_name, :group_ids, :role, :current_user

  validates :email, presence: true

  def initialize(params = {})
    if params[:id].present?
      @user = User.find_by(id: params[:id])
      self.email = params[:email].nil? ? @user.email : params[:email]
      self.first_name = params[:first_name].nil? ? @user.first_name : params[:first_name]
      self.last_name = params[:last_name].nil? ? @user.last_name : params[:last_name]
      self.role = params[:role].nil? ? @user.role : params[:role]
      self.group_ids = params[:group_ids].nil? ? @user.groups.pluck(:id) : params[:group_ids]

    else
      super
    end
  end

  def save
    return false if invalid?
    begin
      ActiveRecord::Base.transaction do
        user = User.invite!(user_params)
        user.groups << Group.where(id: group_ids)
        user.save!
      end

      true
    rescue StandardError => error
      errors.add(:base, error.message)

      false
    end
  end

  def update
    return false if invalid?
    begin
      ActiveRecord::Base.transaction do
        @user.update(user_params)
        @user.touch
        @user.groups = Group.where(id: group_ids)
        @user.save!
      end

      true
    rescue e
      errors.add(:base, e.message)

      false
    end
  end

  private

  def user_params
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      role: role
    }
  end
end
