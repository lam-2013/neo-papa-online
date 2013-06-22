class QuestionTag < ActiveRecord::Base
  attr_accessible :tag_id

  belongs_to :tag
  belongs_to :question










  validates :question_id, presence: true
  validates :tag_id, presence: true

end
