class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :memo, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
