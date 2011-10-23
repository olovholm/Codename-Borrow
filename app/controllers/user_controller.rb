class UserController < ApplicationController
  def register
    redirect_to :action => "new"
    
  end
  
  def login
  end
  
  def new 
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Brukeren din er lagret. Sjekk e-posten din for bekreftelseslink"
      redirect_to :action => "home"
    else 
      flash[:error] = "<em>Vi kom over noen feil når vi skulle lagre brukeren din:</em><br />"
      @user.errors.each {|attr,msg| flash[:error] << "#{attr} #{msg} <br/>" }
      render :action => "new"
    end
  end
end
