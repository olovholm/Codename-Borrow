

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Borrow::Application.initialize!

# Mail configuration.
ActionMailer::Base.delivery_method = :smtp  
ActionMailer::Base.perform_deliveries = true  
ActionMailer::Base.raise_delivery_errors = true   

# Load mail settings
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.someserver.net",
  :port  => 25,
  :user_name  => "someone@someserver.net",
  :password  => "mypass",
  :authentication  => :login
}
