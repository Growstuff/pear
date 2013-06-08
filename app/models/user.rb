class User < ActiveRecord::Base
  devise :omniauthable, :database_authenticatable
  attr_accessible :name, :email, :password, :provider, :uid,
    :available, :time_zone, :can_mentor, :wants_mentor
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

  def tz_string()
    time_zone || 'not set'
  end

  def tz_offset()
    if time_zone
      tz = ActiveSupport::TimeZone[time_zone]
      "UTC#{tz.now.formatted_offset}"
    else
      "not set"
    end
  end

  # pretty sure this can't be done as a scope
  def User.tz_order
    User.available.sort do |a,b|
      atz = a.time_zone
      btz = b.time_zone
      if atz and btz
        ActiveSupport::TimeZone.new(atz).now.utc_offset <=> ActiveSupport::TimeZone.new(btz).now.utc_offset
      else
        1
      end
    end
  end

end
