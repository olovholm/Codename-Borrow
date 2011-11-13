# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private 
  
  def current_user
    @_current_user ||= session[:user_id] && 
    User.find(session[:user_id])
  end
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "Du må være innlogget for å åpne denne siden"
      redirect_to :controller => "user", :action => "login"
    end
  end
  
  
  def logged_in?
    !!current_user
end
