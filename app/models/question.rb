class Question < ActiveRecord::Base

  #variabili accessibili dall'utente
  attr_accessible :age, :content, :title, :category_id

  #una domanda appartiene ad un utente e ad una categoria
  belongs_to :user
  belongs_to :category

  #TO_DO: da mettere in ordine alfabetico
  default_scope order:'questions.created_at DESC'

  has_many :answers, dependent: :destroy

  has_many :question_tags, dependent: :destroy, foreign_key: 'question_id'
  has_many :tags, through: :question_tags #, source: :tag

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :category_id, presence: true
  validates :age, presence: true
  validates :content, presence:true, length: {maximum: 800}

  def tag!(tags )
    question_tags.create!(tag_id: tags.id)
  end

  def self.question_from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
