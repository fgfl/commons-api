source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

gem 'dotenv'
gem 'dotenv-rails', :require => 'dotenv/rails-now'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Cross Origin Resource Sharing
gem 'rack-cors', :require => 'rack/cors'

# use to convert xml to json for feeding to uClassify
gem 'json'
# HTML and XML parser for ruby
gem 'nokogiri'
# Adds additional features to nokogiri for web scraping
gem 'nikkou'

# Interactor gem for organizing business logic
gem "interactor", "~> 3.0"
# Interactor Rails functionality
gem "interactor-rails", "~> 2.0"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Faraday is a wrapper for HTTP client
gem 'faraday'
gem 'faraday_middleware'

# Whenver for scheduling cron jobs 
gem 'whenever', require: false

# Twilio Ruby for sending out SMSes
gem 'twilio-ruby'

# DEVELOPMENT BELOW

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # factory bot 
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  #rspec testing framework
  gem 'rspec-rails', '~> 3.9'
  gem 'pry'
  gem 'spring-commands-rspec'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'minitest', '5.14.0'
  gem 'minitest-rails'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # rspec testing framework
  gem 'shoulda-matchers'
  # simplecov for test coverage
  gem 'simplecov', require: false
end

# # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]