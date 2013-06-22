class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :title
      t.integer :category_id
      t.string :age
      t.string :content

      t.timestamps
    end

    add_index :questions, [:user_id, :created_at]

  end
end
