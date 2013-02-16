class User < ActiveRecord::Base
  devise :omniauthable, :database_authenticatable
  attr_accessible :name, :email, :password, :provider, :uid,
    :available, :time_zone
  scope :available, where(:available => true)

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.login,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                          )
    end
    user
  end

  def offset_string()
    ActiveSupport::TimeZone[time_zone].formatted_offset
  end
end
