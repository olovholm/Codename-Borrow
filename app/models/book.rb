class Book < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  
  
  
  def self.mostPopular 
    puts "Method called"
    where("SELECT books, count(book_id) FROM books_users GROPED by ")
    
  end
end


