class MonetizeBook < ActiveRecord::Migration[6.0]
  def change
    add_monetize :books, :optional_charge, amount: { null: true, default: nil }
  end
end
