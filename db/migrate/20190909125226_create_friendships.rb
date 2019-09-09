class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.string :status, default: "pending"
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :friend, null: false, foreign_key: false, index: { unique: true }

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
