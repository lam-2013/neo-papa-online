class QuestionTag < ActiveRecord::Base
  attr_accessible :tag_id, :question_id

  belongs_to :tag, foreign_key: 'tag_id'
  belongs_to :question, foreign_key: 'question_id'

  validates :question_id, presence: true
  validates :tag_id, presence: true

end
