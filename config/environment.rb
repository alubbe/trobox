# Load the Rails application.
require File.expand_path('../application', __FILE__)

AUTH = YAML.load_file("#{Rails.root}/config/credentials.yml")

# Initialize the Rails application.
Trobox::Application.initialize!
