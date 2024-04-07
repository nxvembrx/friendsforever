class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.text :body, null: false, limit: 1500
      t.references :user, null: false, foreign_key: true
      t.integer :comment_count, null: false, default: 0

      t.timestamps
    end
  end
end
