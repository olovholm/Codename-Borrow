class Notifier < ActionMailer::Base
  default :from  => "ola@lovholm.net"

          
  def welcome(user)
    @user = user
    @url = "http://olovholm001.herokuapp.com"
    mail(:to => user.email, :subject => "Velkommen til borrow. Aktiverings mail" )
  end
  
end
