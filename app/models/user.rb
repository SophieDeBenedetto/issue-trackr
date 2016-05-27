class User < ActiveRecord::Base
  has_many :repositories
  has_many :issues, through: :repositories

  def self.find_or_create_from_omniauth(auth)
    User.find_or_create_by(github_uid: auth["uid"]).tap do |u|
      u.github_username = auth["info"]["nickname"]
      u.email = auth["info"]["email"]
      u.avatar_url = auth["info"]["image"]
      u.name = auth["info"]["name"]
      u.save
    end
  end
end
