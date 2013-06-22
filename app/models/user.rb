class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation, :n_children, :city, :description, :em_situation, :employment, :year, :month, :day

  has_secure_password
  has_private_messages

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

  has_many :amici

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence:true, uniqueness: { case_sensitive: false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :n_children, presence:  true

  validates :city, length: { maximum: 50 }
  validates :description, length: { maximum: 450}
  validates :em_situation, length:{ maximum: 50 }
  validates :employment, length:{ maximum: 50}
  validates :year, length: {maximum: 4}
  validates :month, length: {maximum: 2}
  validates :day, length: {maximum: 2}

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def self.search(user_name)
    if user_name
      where('name LIKE ?', "%#{user_name}%")
    else
      scoped # return an empty result set
    end
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
