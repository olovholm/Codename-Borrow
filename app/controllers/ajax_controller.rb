# encoding: utf-8
require 'net/http' #To use methods towards Google

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
      list = books.map {|b| Hash["id" =>  b.id, "value" =>  b.id, "label" => "#{b.name} av #{b.author}", "name" => b.name, "author" => b.author]}
      render :json =>  list
  end
  
  def add_book 
    if session[:user_id] && params[:book_id]
      @book = Book.where("id = ?", params[:book_id])
      User.find(session[:user_id]).books << @book
      render :text => "La boken \"#{@book[0].name}\" av \"#{@book[0].author}\" til i samlingen din"
    else 
      render :text => "Noe gikk galt. Ikke din skyld dog"
    end
  end
  
  
  def find_postplace
    puts "Method got called with params id: #{params[:id]}"
    if !params[:id].nil? && params[:id].length == 4
      name = User::find_city(params[:id])
      render :text => name
    else
      flash[:error] = "Wow, hold your horses. That was not a legal request"
      redirect_to :controller => "pages", :action => "index"
    end
  end
  
  def find_book_data
    puts "Will try to find book data now"
    envkey = ENV['GOOGLE_API_KEY'] unless ENV['GOOGLE_API_KEY'].nil? 
    uri = URI('https://www.googleapis.com/books/v1/volumes')
    params = {}
    params = [:intitle => params[:name]] unless params[:name].nil?
      
    uri << URI.encode_www_form(params)
    
    res = Net::HTTP.get_response(uri)
    puts res if res.is_a?(Net::HTTPSuccess)
  end
  
end
