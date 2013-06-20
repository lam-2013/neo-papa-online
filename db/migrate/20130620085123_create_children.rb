class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :name
      t.string :city

      t.timestamps
    end

  end
end
