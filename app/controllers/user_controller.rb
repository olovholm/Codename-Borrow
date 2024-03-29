# encoding: utf-8

class UserController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :only => [:new, :create, :register, :login, :welcome]
  
  def register
    redirect_to :action => "new"
  end
        
  
  def new 
    @user = User.new
  end
  
  def glemt 
    #Should send an email to the person asking for more information. 
    #Method name in English?
  end
  
  def list 
    @user = User.find(session[:user_id])
    @books = @user.books
  end
  
  
  def home 
    if not session[:user_id] && [:user_id].nil?
      @user = User.find(session[:user_id])
    else 
      redirect_to :controller => "user", :action => "new"
      flash[:notice] = "Vi sendte deg hit slik at du kan faa bli med i dag, og faa tilgang til din egen hjemside"
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Brukeren din er lagret. Sjekk e-posten din for bekreftelseslink"
      Notifier.welcome(@user).deliver
      begin
        redirect_to :action => "welcome"
      rescue Exception=>e
        puts "SOMETHING IS WRONG WITH THE MAILER"
      end
      session[:register_success] = @user.username
    else 
      flash[:error] = "<em>Vi kom over noen feil når vi skulle lagre brukeren din:</em><br />"
      @user.errors.each {|attr,msg| flash[:error] << "#{attr} #{msg} <br/>" }
      render :action => "new"
    end
  end
  
  def login
    if params[:username] && params[:password]
      @user = User.authenticate(params[:username], params[:password])
      if @user.nil?
        flash[:error] = "Du kunne ikke logges inn"
        redirect_to :action => "login"
      else
        flash[:success] = "Du er nå logget inn #{@user.username}"
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect_to :action => "home"
      end
    end
  end
  
  def logout 
    reset_session 
    flash[:success] = "Du er naa fullstendig logget ut"
    redirect_to :controller => "pages", :action => "index"
    
  end
  
  def welcome
    if session[:register_success]
      @username = session[:register_success]
    else
      @username = nil
    end
  end
    
end
