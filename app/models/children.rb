class Children < ActiveRecord::Base
  attr_accessible :name, :city, :year, :month, :day

  #appartiene ad un utente
  belongs_to :user

  validates :user_id, presence: true
  #campi per la data di nascita
  validates :year, presence: true, length: {is: 4}
  validates :month, presence: true, length: {maximum: 2}
  validates :day, presence: true, length: {maximum: 2}

  #campi non obbligatori: mone e la città dove abita il figlio
  validates :name, length: {maximum: 50}
  validates :city, length: {maximum: 50}
end
