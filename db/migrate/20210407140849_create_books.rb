class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :email
      t.datetime :start_time
      t.integer :people

      t.timestamps
    end
  end
end
