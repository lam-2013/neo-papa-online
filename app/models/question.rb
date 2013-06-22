class Question < ActiveRecord::Base

  attr_accessible :age, :content, :title, :category_id

  default_scope order:'questions.created_at DESC'
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :question_tags,foreing_key: '', dependent: :destroy


  #un utente segue molti utenti attraverso la tabella 'relationship'
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  #un utente è seguito da molti utenti tramite la tabella 'reverse relationship'
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :reverse_relationships


  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :category_id, presence: true
  validates :age, presence: true
  validates :content, presence:true, length: {maximum: 800}

  def self.question_from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
