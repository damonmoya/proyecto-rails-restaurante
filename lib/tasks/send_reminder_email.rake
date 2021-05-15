namespace :emails do
    desc "Sends reminder email to all users whose books last three days"
  
    task :send_reminder => :environment do
        count = 0
        between_time1 = 3*(60*60*24)
        between_time2 = 2*(60*60*24)
        Book.all.each do |book|
            if ((book.start_time.to_i - DateTime.now.utc.to_i)) <= between_time1 && ((book.start_time.to_i - DateTime.now.utc.to_i)) > between_time2 && book.state == "confirmed"
                BookMailer.with(book: book).reminder_book.deliver_now
                count = count + 1
            end
        end
        msg = "Correos de recordatorio enviados: " + count.to_s
        puts msg
    end
end