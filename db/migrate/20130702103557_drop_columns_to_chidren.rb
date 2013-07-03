class DropColumnsToChidren < ActiveRecord::Migration
  def change
    remove_column :children, :year, :integer
    remove_column :children, :month, :integer
    remove_column :children, :day, :integer
  end
end

