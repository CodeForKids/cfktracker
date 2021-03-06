class User < ActiveRecord::Base
  acts_as_paranoid
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

  def weekly_average
    average(:week)
  end

  def monthly_average
    average(:month)
  end

  def average(period)
    times = trackers_by_period(period)[:trackers]
    if times.length > 0
      times.instance_eval { reduce(:+) / size.to_f }.round(2)
    else
      0
    end
  end

  def trackers_as_json(period)
    trackers_by_period(period).to_json
  end

  def trackers_by_period(period)
    trackers = []
    time_periods = []
    times = timetrackers.group_by(&period).sort_by {|key, value| key}
    times.collect do |n, v|
      trackers << v.inject(0) {|n, timetracker| n + timetracker.time }
      time_periods << n
    end
    fill_in_values(time_periods, trackers, period) if time_periods.size > 0
    { time_periods: time_periods, trackers: trackers }
  end

  private

  def fill_in_values(times, trackers, period)
    min = times.min.to_i
    max = max_for_period(period)

    (min..max).each_with_index do |time, index|
      unless times.include?(time.to_s)
        times.insert(index, format_time(time.to_s))
        trackers.insert(index, 0)
      else
        times[index] = format_time(time.to_s)
      end
    end
  end

  def max_for_period(period)
    if period == :week
      Date.today.strftime("%U").to_i
    else
      Date.today.strftime("%y%m").to_i
    end
  end

  def format_time(number)
    number = Date::MONTHNAMES[number[2, number.length].to_i] if number.to_i > 52
    number.to_s
  end

end
