class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 6, maximum: 5000 }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
