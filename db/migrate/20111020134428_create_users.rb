class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "username"
      t.string "hashed_password"
      t.string "salt"
      t.string "email"
      t.string "fullname"
      t.string "address"
      t.string "postcode"
      t.datetime "birthdate"
      t.boolean "activated"
      t.boolean "visible"
      t.float "latitude"
      t.float "longitude"

      t.timestamps
    end
  end
end
