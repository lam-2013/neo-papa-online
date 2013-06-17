class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :n_children

  has_secure_password

  has_many :posts, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence:true, uniqueness: { case_sensitive: false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :n_children, presence:  true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
