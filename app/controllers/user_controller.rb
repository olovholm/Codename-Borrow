class UserController < ApplicationController
  def register
    redirect_to :action => "new"
  end
        
  
  def new 
    @user = User.new
  end
  
  def glemt 
  
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Brukeren din er lagret. Sjekk e-posten din for bekreftelseslink"
      redirect_to :action => "home"
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
  
  
end
