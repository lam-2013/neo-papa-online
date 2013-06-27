class Post < ActiveRecord::Base

  #Muro dello sfogo
  attr_accessible :content

  #appartiene ad un utente
  belongs_to :user

  #ordine dei post di default, usato quando vengono richiamati
  default_scope order:'posts.created_at DESC'

  #campi obbligatori
  validates :user_id, presence: true
  validates :content, presence:true, length: {maximum: 400}

  #id mio e dei miei followed
  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

  #cercare i post solo di oggi (muro dello sfogo)
  def self.todays_post
    post_today_ids = 'select id from posts where created_at >=  date(\'now\')'
    where("id IN (#{post_today_ids})")
  end

end
