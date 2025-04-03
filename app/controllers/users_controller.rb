class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @upcoming_attended_events = @user.attended_events.upcoming
    @past_attended_events = @user.attended_events.past
  end
end
