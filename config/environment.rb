

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Borrow::Application.initialize!

# Mail configuration.
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'your.host.name',
  :user_name            => ENV['GMAIL_SMTP_USER'],
  :password             => ENV['GMAIL_SMTP_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true  }


