

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Borrow::Application.initialize!

# Mail configuration.
ActionMailer::Base.delivery_method = :sendmail  
ActionMailer::Base.perform_deliveries = true  
ActionMailer::Base.raise_delivery_errors = true  
