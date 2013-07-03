class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation, :n_children, :city, :description, :em_situation, :employment, :birthday

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_secure_password
  has_private_messages

  # un utente scrive molte domande, molte risposte, molti post e ha molti figli; può eliminare post, domande e risposte
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :childrens

  #un utente segue molti utenti attraverso la tabella 'relationship'
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  #un utente è seguito da molti utenti tramite la tabella 'reverse relationship'
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :reverse_relationships

  #ad un utente piace una domanda tramite la tabella like_questions
  has_many :like_questions, foreign_key: 'user_id', dependent: :destroy
  has_many :like_q, through: :like_questions, source: :question

  #ad un utente piace una risposta tramite la tabella like_answers
  has_many :like_answers, foreign_key: 'user_id', dependent: :destroy
  has_many :like_a, through: :like_answers, source: :answer

  #campi obbligatori --> validazioni
  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence:true, uniqueness: { case_sensitive: false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :n_children, presence: true, :numericality => true

  #campi non obbligatori --> validazioni
  validates :city, length: { maximum: 50 }
  validates :description, length: { maximum: 450}
  validates :em_situation, length:{ maximum: 50 }
  validates :employment, length:{ maximum: 50}

  # metodi per i followers e i floowed
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  #metodi per i "Mi piace/Non mi piace più" per le domande
  def like_questions?(question)
    like_questions.find_by_question_id(question.id)
  end

  def like_questions!(question)
    like_questions.create!(question_id: question.id)
  end

  def dont_like_questions!(question)
    like_questions.find_by_question_id(question.id).destroy
  end

  #metodi per i "Mi piace/Non mi piace più" per le risposte
  def like_answers?(answer)
    like_answers.find_by_answer_id(answer.id)
  end

  def like_answers!(answer)
    like_answers.create!(answer_id: answer.id)
  end

  def dont_like_answers!(answer)
    like_answers.find_by_answer_id(answer.id).destroy
  end

  #metodo: prende i post con user_id uguale a quelli trovati dal metodo from_users_followed_by (mio e miei followed)
  def feed
    Post.from_users_followed_by(self)
  end

  #metodo: prende le domande con user_id uguale a quelli trovati dal metodo from_users_followed_by (mio e miei followed)
  def query
    Question.from_users_followed_by(self)
  end

  #metodo: prende le risposte con user_id uguale a quelli trovati dal metodo from_users_followed_by (mio e miei followed)
  def answer
    Answer.from_users_followed_by(self)
  end

  #metodo per la ricerca tramite il nome degli utenti (ricerca in alto)
  def self.search(user_name)
    if user_name
      where('name LIKE ?', "%#{user_name}%")
    else
      scoped # return an empty result set
    end
  end


  #metodi privati
  private

  #creazione remeber_token per la sessione
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
