class CreateUserFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_friendships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :friend, index: true
      t.boolean :pending, default: true

      t.timestamps
    end
    add_index :user_friendships, %i[user_id friend_id], unique: true
  end
end
