class Timetracker < ActiveRecord::Base
  belongs_to :user
  validates :date, :description, presence: true
  validates :time, numericality: { less_than_or_equal_to: 24 }

  def self.received(current_user)
    where(user: current_user, received: true).map(&:time).inject(0, &:+)
  end

  def self.unreceived(current_user)
    where(user: current_user, received: false).map(&:time).inject(0, &:+)
  end

  def class_for_toggle
    if received
      'thumbs-down'
    else
      'thumbs-up'
    end
  end

  def received_for_toggle_as_words
    if received
      'unreceived'
    else
      'received'
    end
  end

end
