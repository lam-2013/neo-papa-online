class AddColumnDateBirthTo < ActiveRecord::Migration
 def change
   add_column :users, :birthday, :date
 end
end
