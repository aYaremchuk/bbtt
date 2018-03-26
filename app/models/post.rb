class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  has_and_belongs_to_many :groups
  has_one_attached :image
end
