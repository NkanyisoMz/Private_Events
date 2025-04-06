class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_event, only: %i[edit update destroy]
  before_action :authorize_creator!, only: %i[edit update destroy]

  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])

# Allow access only if creator or invited user
unless @event.creator == current_user || @event.invited_users.include?(current_user)
  redirect_to events_path, alert: "This is a private event."
end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to events_path, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
    if params[:invited_user_ids]
      params[:invited_user_ids].each do |id|
        @event.invitations.create(user_id: id)
      end
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated!"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted!"
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_creator!
    redirect_to events_path, alert: "You are not authorized!" unless @event.creator == current_user
  end
end
