class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id

  default_scope order:'questions.created_at DESC'
  belongs_to :user

  belongs_to :question


  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence:true, length: {maximum:400}

  def self.answer_from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
