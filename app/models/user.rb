class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable
  #
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: %i(user admin)
end
