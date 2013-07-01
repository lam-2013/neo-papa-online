class CreateLikeQuestions < ActiveRecord::Migration
  def change
    create_table :like_questions do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
