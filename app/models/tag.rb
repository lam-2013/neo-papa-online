class Tag < ActiveRecord::Base
  attr_accessible :title

  has_many :question_tags, foreign_key: 'question_id'
  has_many :questions, through: :question_tags #, source: :question


  def has_question!(questions)
    question_tags.create!(question_id: questions.id)
  end

end
