class DropColumnsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :year, :integer
    remove_column :users, :month, :integer
    remove_column :users, :day, :integer
  end
end
