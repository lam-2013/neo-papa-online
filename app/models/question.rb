class Question < ActiveRecord::Base

  #variabili accessibili dall'utente
  attr_accessible :age, :content, :title, :category_id

  #una domanda appartiene ad un utente e ad una categoria
  belongs_to :user
  belongs_to :category

  #TO_DO: da mettere in ordine alfabetico
  #ordinamento di default in base alla data di creazione
  default_scope order:'questions.created_at DESC'

  #una domanda ha molte risposte
  has_many :answers, dependent: :destroy

  #una domanda ha molte tuple nella tabella question_tags, una domanda ha molti tag attraverso la tabella question_tag
  has_many :question_tags, dependent: :destroy, foreign_key: 'question_id'
  has_many :tags, through: :question_tags #, source: :tag

  #validazioni dei campi: tutti sono obbligatori
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :category_id, presence: true
  validates :age, presence: true
  validates :content, presence:true, length: {maximum: 800}


  #metodo per inserire i tag nella tabella question_tag
  def tag!(tags )
    question_tags.create!(tag_id: tags.id)
  end

  #cerca gli id del mio utente e dei miei followed
  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
