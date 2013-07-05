class AddThreeColumnToCategories < ActiveRecord::Migration
  def change

    add_column :categories, :user_id, :integer
    add_column :categories, :waiting, :boolean, default: true
    add_column :categories, :accepted, :boolean, default: false

  end
end

