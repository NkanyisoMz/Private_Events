class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    return redirect_to root_path if params[:id] == "sign_out"

    @user = User.find(params[:id])
    @upcoming_attended_events = @user.attended_events.upcoming
    @past_attended_events = @user.attended_events.past
  end
end
