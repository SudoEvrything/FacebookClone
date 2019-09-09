class User < ApplicationRecord
	
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 250 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	def request_friendship(target_user)
    friendship = friendships.create(user_id: self.id, friend_id: target_user.id)
    target_user.inverse_friendships << friendship
  end

  def all_friendships
    Friendship.where('friend_id = ? OR user_id = ?', self.id, self.id)
  end

  def relationship_status(target_user)
    if all_friends.include?(target_user)
      self.find_friendship(target_user).status
    else
      'Not Friends'
    end
  end

  def is_friend?(target_user)
    self.all_friends.include?(target_user)
  end

  def find_friendship(target_user)
    friend = Friendship.where("friend_id = ? AND user_id = ?", target_user.id, self.id).take
    inverse_friend = Friendship.where("friend_id = ? AND user_id = ?", self.id, target_user.id).take
    friend.nil? ? inverse_friend : friend
  end

  def all_friends
    # needs serious refactoring
    requested_friends = self.friends
    requesting_friends = self.inverse_friends
    all_friends = []
    User.all.each do |user|
      all_friends << user if requested_friends.include?(user)
      all_friends << user if requesting_friends.include?(user)
    end
    all_friends
  end


	def feed
		Post.where("user_id = ?", id)
	end

	def likes?(post)
    self.likes.include?(user_like(post))
  end

  def user_like(post)
    Like.where(user_id: self.id, post_id: post.id).take
  end
end
