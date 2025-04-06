# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances, source: :attendee

  has_many :invitations
  has_many :invited_users, through: :invitations, source: :user


  scope :past, -> { where("date < ?", Time.now).order(date: :asc) }
  scope :upcoming, -> { where("date >= ?", Time.now).order(date: :asc) }
end
