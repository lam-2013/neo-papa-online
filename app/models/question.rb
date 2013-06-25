class Question < ActiveRecord::Base

  attr_accessible :age, :content, :title, :category_id

  default_scope order:'questions.created_at DESC'
  belongs_to :user

  has_many :answers, dependent: :destroy

  has_many :question_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :tags, through: :question_tags #, source: :tag

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :category_id, presence: true
  validates :age, presence: true
  validates :content, presence:true, length: {maximum: 800}

  def has_tag!(tags)
    question_tags.create!(tag_id: tags.object_id)
  end

  def self.question_from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
