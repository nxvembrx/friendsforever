class CreateUserFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_friendships do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :friend, null: false, foreign_key: true, index: true
      t.boolean :pending, default: true

      t.timestamps
    end
    add_index :user_friendships, %i[user_id friend_id], unique: true
  end
end
