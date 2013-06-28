class Answer < ActiveRecord::Base
  attr_accessible :content, :user_id, :question_id

  default_scope order:'answers.created_at DESC'

  #una risposta appartiene a un utente e ad una domanda
  belongs_to :user
  belongs_to :question

  #validazioni campi
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence:true, length: {maximum:400}

  #restituisce gli id dell'utente che è loggato e dei suoi follwed
  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
