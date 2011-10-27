class BooksController < ApplicationController
  
  def list
    redirect_to :controller => "user", :action => "list"
    
  end
  
  def new
    @book = Book.new
    
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
