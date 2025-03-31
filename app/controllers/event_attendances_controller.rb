class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    unless event.attendees.include?(current_user)
      event.attendees << current_user
    end
    redirect_to event, notice: "You are now attending this event!"
  end
end
