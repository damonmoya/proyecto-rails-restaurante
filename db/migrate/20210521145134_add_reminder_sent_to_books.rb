class AddReminderSentToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :reminder_sent, :integer, default: 0
  end
end
