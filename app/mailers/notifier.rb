class Notifier < ActionMailer::Base
  default :from => "from@example.com",
          :return_path => "system@example.com"
          
  def welcome(recipient)
    @user = recipient
    mail(:to => recipient.email)
  end
  
end
