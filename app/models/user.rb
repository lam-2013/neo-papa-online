class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_secure_password


  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence:true, uniqueness: { case_sensitive: false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


end
