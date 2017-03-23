class ParticipationsController < ApplicationController
  def create
      event = Event.find(params[:id])
      Participation.create(user: current_user, event: event)
      redirect_to "/events"
  end

  def destroy
      event = Event.find(params[:id])
      Participation.find_by(user: current_user, event: event).destroy
      redirect_to "/events"
  end
end
