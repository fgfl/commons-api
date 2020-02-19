# DISABLE BELOW FOR PRODUCTION
set :environment, "development"
set :output, {:error => "log/when_err_log-#{DateTime.now()}.log", :standard => "log/when_update_log-#{DateTime.now()}.log"}

# Use this file to easily define all of your cron jobs.

# Chronic Time Settings
set :chronic_options, hours24: nil

# Regular Scheduled Tasks
every 1.day, at: '12:30 am' do
  p "Started updating Database at #{DateTime.now()}"
  rake "db:update_database", :environment => "development"
  p "Finished Updating Database at: #{Time.now} - Success!"
end

# TEST UPDATER
every 1.day, at: '11:07 pm' do
  p "Started updating Database at #{DateTime.now()}"
  rake "db:update_database", :environment => "development"
  p "Finished Updating Database at: #{Time.now} - Success!"
end