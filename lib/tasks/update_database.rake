namespace :db do
  desc "TODO"
  task :update_database => :environment do
    puts "Updating Database at #{DateTime.now()}"
    url = ENV["legisinfo_url"]
    WriteToDb.call({url: url})
    puts "Finished Updating Database at: #{Time.now} - Success!"
  end
end
