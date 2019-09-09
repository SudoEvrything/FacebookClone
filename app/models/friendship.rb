class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates   :user_id, :friend_id, presence: true
  validate    :cannot_friend_self
  validates   :status,  inclusion: { in: ['pending', 'friends'] }

  private 

    def cannot_friend_self
      if friend_id == user_id
        errors.add(:friend_id, "can't be the same as the User's id.")
      end
    end
end
