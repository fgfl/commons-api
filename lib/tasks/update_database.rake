namespace :db do
  desc "TODO"
  task :update_database => :environment do
    puts "Updating Database at #{DateTime.now()}"
    WriteToDb.call
    puts "Finished Updating Database at: #{Time.now} - Success!"
  end
end
