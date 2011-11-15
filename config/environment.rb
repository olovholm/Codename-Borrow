

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Borrow::Application.initialize!

# Mail configuration.
ActionMailer::Base.smtp_settings = {
  :user_name  => ENV['SENDGRID_USERNAME'],
  :password   => ENV['SENDGRID_PASSWORD'],
  :domain => "borrowapp.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

