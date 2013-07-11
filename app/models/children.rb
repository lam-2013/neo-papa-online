class Children < ActiveRecord::Base
  attr_accessible :name, :city, :birthday

  #appartiene ad un utente
  belongs_to :user

  validates :user_id, presence: true

  #campi per la data di nascita
  validates :birthday,presence: true

  #campi non obbligatori: mone e la città dove abita il figlio
  validates :name, length: {maximum: 50}
  validates :city, length: {maximum: 50}
end
