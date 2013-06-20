class AddOtherInformationsToUsers < ActiveRecord::Migration
  def change

    add_column :users, :city, :string
    add_column :users, :description, :string
    add_column :users, :em_situation, :string
    add_column :users, :employment, :string

  end
end
