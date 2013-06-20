class Children < ActiveRecord::Base
  attr_accessible :name, :city, :year, :month, :day

  belongs_to :user

  validates :user_id, presence: true
  validates :year, presence: true, length: {is: 4}
  validates :month, presence: true, length: {maximum: 2}
  validates :day, presence: true, length: {maximum: 2}

  validates :name, length: {maximum: 50}
  validates :city, length: {maximum: 50}
end
