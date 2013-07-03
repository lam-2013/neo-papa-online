class CreateLikeAnswers < ActiveRecord::Migration
  def change
    create_table :like_answers do |t|
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end

