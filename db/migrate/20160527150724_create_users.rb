class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_uid
      t.string :avatar_url
      t.string :name
      t.string :email
      t.string :github_username
      t.string :phone_number
      t.timestamps null: false
    end
  end
end
