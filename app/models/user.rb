class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  #
  devise :registerable, :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: %i(user admin)

  validates :email, presence: true, uniqueness: true

  has_many :posts
  has_and_belongs_to_many :groups
end
