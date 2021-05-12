class CreateChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :checks do |t|
      t.string :token
      t.string :email
      t.datetime :expire_time

      t.timestamps
    end
  end
end
