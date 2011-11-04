class PagesController < ApplicationController
  def index
    
  end
  
  def hello
    
  end
  
  def kontakt
    @user = User.find(session[:user_id]) if session[:user_id]
    
  end
end
