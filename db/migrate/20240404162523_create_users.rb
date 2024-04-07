class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, limit: 40, null: false, unique: true

      t.timestamps
    end
  end
end
