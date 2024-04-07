class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :display_name, limit: 50
      t.string :location, limit: 40
      t.string :website, limit: 50
      t.string :pronouns, limit: 40
      t.text :bio, limit: 400
      t.date :birthday
      t.string :profile_picture
      t.string :banner_picture

      t.timestamps
    end
  end
end
