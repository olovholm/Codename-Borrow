# encoding: utf-8
class BooksController < ApplicationController
  before_filter :require_login
  
  def list
    redirect_to :controller => "user", :action => "list"
    
  end
  
  def new
    @book = Book.new
    
  end
  
  def remove
    @book = Book.find(params[:id])
    @user = User.find(session[:user_id])
    @user.books.delete(@book)
    redirect_to :controller => "user", :action => "list"
  end
  
  def compare
    #Should find other users that also owns this book. -> In the long run this should be limited to friends
  end
  
  def create 
    @book = Book.new(params[:book])
    @user = User.find(session[:user_id])
    if @book.save
      flash[:success] = "Boken (#{@book.name}) ble lagret"
      @user.books << @book
      
      redirect_to :controller => "user", :action => "list"
    else
      flash[:error] = "<em>Vi kom over noen feil naar vi skulle lagre boken din:</em><br />"
      @user.errors.each {|attr,msg| flash[:error] << "#{attr} #{msg} <br/>" }
      render :action => "new"
    end
  end
  
end
