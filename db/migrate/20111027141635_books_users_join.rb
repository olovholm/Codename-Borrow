class BooksUsersJoin < ActiveRecord::Migration
  def up
    create_table :books_users, :id => false do |t|
      t.integer "user_id"
      t.integer "book_id"
    end
    add_index :books_users, ["user_id", "book_id"]
  end

  def down
    drop_table :books_users
  end
end
