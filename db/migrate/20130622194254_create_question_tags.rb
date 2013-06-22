class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.integer :question_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :question_tags, [ :question_id, :tag_id ], unique: true

  end
end
