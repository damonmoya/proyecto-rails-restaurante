namespace :emails do
    desc "Sends reminder email to all users whose books last three days"
  
    task :send_reminder => :environment do
        between_time1 = 3*(60*60*24)
        Book.all.each do |book|
            if ((book.start_time.to_i - DateTime.now.utc.to_i)) <= between_time1 && book.state == "confirmed" && book.reminder_sent == 0
                book.reminder_sent = 1
                book.save
                BookMailer.with(book: book).reminder_book.deliver_now
            end
        end
    end
end