class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, limit: 30, null: false
      t.string :location, limit: 30
      t.string :website, limit: 35
      t.string :pronouns, limit: 30
      t.text :bio, limit: 350
      t.date :birthday

      t.timestamps
    end
  end
end
