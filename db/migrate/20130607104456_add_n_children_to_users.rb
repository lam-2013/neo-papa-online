class AddNChildrenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :n_children, :integer
  end

end
