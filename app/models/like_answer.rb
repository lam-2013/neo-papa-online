class LikeAnswer < ActiveRecord::Base
  attr_accessible :answer_id

  #appartiene agli utenti e alle risposte
  belongs_to :user
  belongs_to :answer

  #le due chiavi esterne devono essere sempre presenti
  validates :user_id, presence: true
  validates :answer_id, presence: true

end
