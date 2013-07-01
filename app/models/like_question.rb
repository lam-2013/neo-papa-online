class LikeQuestion < ActiveRecord::Base
  attr_accessible :question_id

  #appartiene agli utenti ed alle domande
  belongs_to :user
  belongs_to :question

  #le due chiavi esterne devono essere sempre presenti
  validates :user_id, presence: true
  validates :question_id, presence: true
end
