class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string "name"
      t.string "author"
      t.string "publisher"
      t.string "language"
      t.string "isbn"

      t.timestamps
    end
  end
end
