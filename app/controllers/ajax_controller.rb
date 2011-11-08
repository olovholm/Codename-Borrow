class AjaxController < ApplicationController
  def find_books
    if params[:term] && params[:term].length > 2
      like = "%".concat(params[:term].concat("%"));
      puts "in if\n\n"
      puts like
      books = Book.where("name like ?", like);
      puts books
    else
      books = nil
    end
      list = books.map {|u| "#{u.name} - #{u.author}"} unless books.nil?
    render :json =>  list
  end
end
