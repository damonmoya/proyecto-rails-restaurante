class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :email
      t.datetime :start_time
      t.integer :diners
      t.boolean :is_confirmed, default: false

      t.timestamps
    end
  end
end
