namespace :db do
  desc "Runs the SaveUclassifyCategories Interactor Organier to update the database with current bills and events."
  task :update_database => :environment do
    puts "Updating Categories at #{DateTime.now()}"
    SaveCategoriesFromUclassify.call({url: url})
    puts "Finished Updating Categories at: #{Time.now} - Success!"
  end
end
