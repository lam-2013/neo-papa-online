class Category < ActiveRecord::Base
  attr_accessible :title, :user_id, :waiting, :accepted

  #ha molte domande
  has_many :questions

  belongs_to :user

  validates :title, presence: true
  validates :user_id, presence: true

end
