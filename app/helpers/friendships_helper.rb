module FriendshipsHelper

  def friendship_exists?(target_user, user=current_user)
    Friendship.where("user_id = ? AND friend_id = ?", user.id, target_user.id).any?
  end

  def other_user_in_friendship(friendship)
    friend = User.find(friendship.friend_id)
    user = User.find(friendship.user_id)
    current_user == friend ? user : friend 
  end

end
