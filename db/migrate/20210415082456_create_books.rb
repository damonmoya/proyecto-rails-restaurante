class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :email
      t.datetime :start_time
      t.integer :diners
      t.integer :state, default: 0
      t.integer :reminder_sent, default: 0

      t.timestamps
    end
  end
end
