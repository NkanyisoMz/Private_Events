class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    unless event.attendees.include?(current_user)
      event.attendees << current_user
    end
    redirect_to event, notice: "You are now attending this event!"
  end

  def destroy
    attendance = EventAttendance.find_by(user: current_user, event_id: params[:event_id])
    attendance.destroy if attendance
    redirect_to events_path, notice: "You are no longer attending this event."
  end
end
