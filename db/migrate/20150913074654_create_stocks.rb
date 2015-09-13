class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.string :symbol
      t.date :last_updated

      t.timestamps null: false
    end
  end
end
