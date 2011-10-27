class UserController < ApplicationController
  def register
    redirect_to :action => "new"
  end
        
  
  def new 
    @user = User.new
  end
  
  def glemt 
  
  end
  
  
  def home 
    if not session[:user_id].nil?
      @user = User.find(session[:user_id])
    else 
      redirect_to :controller => "user", :action => "new"
      flash[:notice] = "Vi sendte deg hit slik at du kan faa bli med i dag, og faa tilgang til din egen hjemside"
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Brukeren din er lagret. Sjekk e-posten din for bekreftelseslink"
      Notifier.welcome(@user).deliver
      redirect_to :action => "welcome"
      session[:register_success] = @user.username
    else 
      flash[:error] = "<em>Vi kom over noen feil naar vi skulle lagre brukeren din:</em><br />"
      @user.errors.each {|attr,msg| flash[:error] << "#{attr} #{msg} <br/>" }
      render :action => "new"
    end
  end
  
  def login

    if params[:username] && params[:password]
      @user = User.authenticate(params[:username], params[:password])
      if @user.nil?
        flash[:error] = "You could not be logged in"
        redirect_to :action => "login"
      else
        flash[:success] = "Du er naa logget inn #{@user.username}"
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
  
  def postplace_ajax
    puts "Method got called with params id: #{params[:id]}"
    if !params[:id].nil? && params[:id].length == 4
      name = User::find_city(params[:id])
      render :text => name
    else
      flash[:error] = "Wow, hold your horses. That was not a legal request"
      redirect_to :controller => "pages", :action => "index"
    end
  end
  
end
