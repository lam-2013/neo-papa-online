class Tag < ActiveRecord::Base
  attr_accessible :title

  #un tag ha molte tuple nella tabella question_tags ed ha molte deomande attraverso la stessa tabella
  has_many :question_tags, foreign_key: 'question_id'
  has_many :questions, through: :question_tags #, source: :question

end
