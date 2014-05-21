class User < ActiveRecord::Base
  has_many :timetrackers

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end

  def total_received_hours
    Timetracker.where(user: self, received: true).map(&:time).inject(0, &:+)
  end

  def total_unreceived_hours
    Timetracker.where(user: self, received: false).map(&:time).inject(0, &:+)
  end

end
