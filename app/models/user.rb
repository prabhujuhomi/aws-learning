class User < ApplicationRecord
  has_one_attached :profile_picture
  validates :name, :email, presence: true
end
