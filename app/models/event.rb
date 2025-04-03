class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances, source: :attendee

  # Class methods for filtering past and upcoming events
  def self.past
    where("date < ?", Date.today)
  end

  def self.upcoming
    where("date >= ?", Date.today)
  end
end
